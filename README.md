# SQServiceStorage

**SQServiceStorage**는 YouTube 플레이리스트 정보를 Supabase 데이터베이스에 캐싱하고 관리하는 Swift 패키지입니다.

## 주요 기능

### 🎵 YouTube 플레이리스트 캐싱
- **Official 플레이리스트**: YouTube 공식 플레이리스트 정보 저장 및 관리
- **Video 플레이리스트**: 단일 비디오에서 추출된 음악 정보와 시작 시간 관리
- **음악 플랫폼 지원 대비**: Apple Music, Spotify 등 다양한 플랫폼 지원

### 🗄️ 데이터베이스 관리
- **Supabase 통합**: Supabase 클라이언트를 통한 실시간 데이터 동기화
- **효율적인 쿼리**: 최적화된 데이터베이스 쿼리 및 RPC 함수 지원

### 📊 API 쿼리 기능
- **차트 데이터**: 음악 차트 정보 조회
- **채널 정보**: YouTube 채널 메타데이터 관리
- **Sqoops 로그**: 플레이리스트 스쿱 로그 처리

## 아키텍처

```
SQServiceStorage/
├── PlaylistCachier/          # 플레이리스트 캐싱 핵심 로직
├── SQSupabaseQuerier/        # API 쿼리 관리
├── SupabaseStorage/          # 데이터베이스 연결 및 쿼리
├── Model/                    # 데이터 모델 및 DTO
└── Utility/                  # 유틸리티 및 확장 기능
```


## 설치 요구사항

- **iOS 16.0+** 또는 **macOS 13.0+**
- **Swift 5.10+**
- **Supabase Swift SDK 2.0.0+**

## 라이선스

이 프로젝트는 GNU General Public License v3.0 하에 배포됩니다.

# 주요 API 명세

## 1. PlaylistCachier
> 플레이리스트 정보 서버 보관용 API | SUPABASE DB 직접 접근

## 2. PlaylistQuerier

> 플리 차트, 채널, 스쿱 로그 등 서비스 API | EdgeFunction에 접근
 
-> PlaylistQuereir는 Legacy... 직접 SUPABASE DB Procedure 호출

1. ChartsQurier - 차트 관련 API 객체
2. ChannelsQuerier - 채널 관련 API 객체
    - 채널 플레이리스트 조회
3. SqoopsQuerier - 로그 및 스쿱 서비스 필수 로직 객체
    - 로그 POST
