## 1. 개요

> 사용자가 스쿱한 플레이리스트를 외부 서버에 보관하여 여러 기능을 제공하는 패키지입니다.
> 

### 핵심 기능

**1. 외부 서버를 이용한 사용자가 스쿱한 플레이리스트를 DB `모델링` 후 캐싱**

- PlaylistCachier 객체에서 관리
- **PlaylistHead**: 플레이리스트 데이터의 데이터를 명시하는 객체, 메타데이터 역할
- **PlaylistBody**: 플레이리스트 곡 정보 리스트를 명시하는 객체

**2. 외부 서버에 보관한 플레이리스트 정보들을 활용한 최근 스쿱한 플레이리스트 리스트 제공**

- PlaylistQuerier에 객체에서 관리

## 2. 핵심 비즈니스 로직


<img width="800" alt="db개발 (1)" src="https://github.com/user-attachments/assets/4c3cbcba-8164-4205-bf8a-0a48bc5e71a6" />

## 3. 기술 내용 정리

### DB Query Table과 패키지 API 통신용 DTO 제작

서버에서 저장하는 정보의 형태에 메인 프로젝트에서 직접 적용하지 않도록 메인 프로젝트에 사용하기 적합한 형태로 바꾸었습니다.

1. **DB Query Table**
    
<img width="800" alt="개발도식 (1)" src="https://github.com/user-attachments/assets/a547a86c-1cd9-4843-a38e-7afa24ece21d" />

    
2. **Sqoop API DTO**

### Supabase PostreSQL을 이용한 Query Function 제작 및 활용

쿼리를 이용하여 서버에서 원하는 값을 빠르게 가져올 수 있는 API 함수를 만들었습니다.

https://postgresql.kr/docs/13/sql-createfunction.html

<aside>


💡 Query Function을 사용함에 있어 경험한 장점을 요약하면 다음과 같습니다.

</aside>

1. 일부 형 변환 및 연산, 정렬 로직을 SQL 쿼리 문으로 서버 처리가능
2. 클라이언트 측에서의 연산과정이 아닌, 서버 측에서 연산과정 처리 가능
3. DB Migration 시, Query Function에 접근하기 때문에 클라이언트 종속에 벗어난 더 유연한 DB 테이블 업데이트 가능

**제작한 PostreSQL 함수**

- PlaylistAccessByDateDESC → 최신 스쿱한 플레이리스트를 기준으로 플레이리스트 ID 배열 반환
- **⭐ getHeads → id 배열 입력시 PlaylistHead 배열 반환**
    - DB의 Playlist Head 테이블에는 채널의 id만 갖고 있습니다. 하지만, Playlist Head DTO는 채널의 이름으로 접근 가능하게 설정했습니다.
    - 기존 단순 DB값 조회 Supabase API를 사용한다면 Playlist Head 테이블과 Channel Info 테이블 2가지를 패키지에 직접 만들고 이 두 테이블 객체를 사용한 Playlist Head DTO 반환 로직을 추가로 작성해야합니다.
    - 하지만 PostreSQL 쿼리 Function을 만들어 위의 형 변환 처리에 `where` 쿼리 연산자 훨씬 간단하게 해결할 수 있었습니다.
    - 전체 코드
        
        ```sql
        drop function if exists getheads(ids varchar[]);
        
        create
        or replace function getheads(ids varchar[]) returns table (
          "id" varchar,
          "originURL" text,
          "title" text,
          "thumbnailURLString" text,
          "insertedDate" timestamp with time zone,
          "isShazamed" boolean,
          "playlistType" "YTPlaylistType",
          "channelID" varchar,
          "channelName" text
        ) as $$
        begin
          return query
          select 
            head.id as "id",
            head."originURL" as "originURL",
            head."title" as "title",
            head."thumbnailURLString" as "thumbnailURLString",
            head."insertedDate" as "insertedDate",
            head."isShazamed" as "isShazamed",
            head."playlistType" as "playlistType",
            head."channelID" as "channelID",
            channel."name" as "channelName"
          from "YTPlaylistHead" as head
          inner join "YTChannelInfo" as channel on head."channelID" = channel.id
          where head.id = ANY(ids)
          order by array_position(ids, head.id);
        end
        $$ language plpgsql;
        ```
        
- getIsShazamed → 플레이리스트 ID를 기반해 이미 2차 스쿱을 진행했는지 알려줍니다.
- **⭐ getTotalSongCount → 현재 DB에 담긴 노래 개수를 알 수 있습니다.**
    - DB에는 노래 정보만 저장하는 순수 테이블이 없습니다. 각각의 플레이리스트에 속한 곡의 정보로 저장합니다. ⇒ A 플레이리스트 a곡과 B 플레이리스트의 a곡은 각각 따로 저장된다..!
    - 이로 인해 순수한 각기 다른 곡의 갯수를 반환하는데에는 중복을 제거하는 로직이 필요했습니다.
    - 전체 코드
        
        ```sql
        drop function if exists gettotalsongcount();
        
        create
        or replace function gettotalsongcount() returns integer as $$
          begin
            RETURN (SELECT COUNT(DISTINCT "ISRC") FROM "MusicInfoJoin");
          end
        $$ language plpgsql;
        ```
        
- getTotalPlaylistCount → 현재 DB에 담긴 플레이리스트 개수를 알 수 있습니다.

### Cache API와 Querier API 분리

Sqooping 서비스가 발전하고 사용자가 증가하면서 사용자에게 우리 서비스에서 최근에 스쿱한 플레이리스트를 보여주는 기능을 도입하고자 했습니다.

이 기능을 도입하면서 기존 캐시를 위해 접근하는 DB가 아닌, 추가적인 기능을 사용하기 위한 DB 접근이 발생했고, 각각의 특성이 뚜렷히 다르다는 것을 인지하여 담당 API 객체를 분리하였습니다.

1. Cache API: 본인 혹은 다른 사용자가 이미 Sqoop한 플레이리스트 다시 Sqoop 할 때, 추출 로직을 재사용하지 않도록 도와주는 API 객체 입니다.
    
    캐시 API는 핵심 서비스(Sqoop)에 트래픽 정보를 얻거나 추가할 수 있습니다.
    
    ⇒ 새로운 플레이리스트가 추가됨, 특정 플레이리스트가 재사용됨, 특정 플레이리스트 크리에이터의 플레이리스트가 사용됨 등…
    
2. Querier API: 기존 캐시된 정보 및 캐시하면서 내부적으로 추가로 저장한 트래픽 정보들의 값들을 기반하여 기능별로 원하는 정보를 제공하는 API 객체입니다.

