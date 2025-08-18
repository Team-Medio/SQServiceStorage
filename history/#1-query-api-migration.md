# Query API Migration v1

## 작업 개요
기존 데이터베이스 구조를 개선하고 새로운 Query API 시스템을 구축하는 마이그레이션 작업

## 주요 변경사항

### 1. 데이터베이스 스키마 개선
- **HeadAccessDateTable 제거**: 불필요한 테이블 제거로 데이터베이스 구조 단순화

### 2. SQSupabaseQuerier 시스템 구축
- **새로운 Querier 서비스 제작**:
  - **LEGACY**: `PlaylistQuerier.swift` - 플레이리스트 관련 쿼리
  - `ChartsQuerier.swift` - 차트 데이터 쿼리  
  - `ChannelsQuerier.swift` - 채널 정보 쿼리
  - `SqoopsQuerier.swift` - Sqoops 로그 쿼리

### 3. EndPoint 시스템 개선
- **API 엔드포인트 구조화**:
  - `ChannelsEndPoint.swift`
  - `ChartsEndPoint.swift` 
  - `PlaylistIDsRequest.swift`
  - `SqoopsEndPoint.swift`

### 4. PlaylistCachier 개선
- HeadAccessDateTable 제거에 따른 최근 스쿱 플리 리팩토링

### 5. 에러 처리 및 DTO 구조 개선
- **새로운 에러 타입 추가**:
  - `NetworkingError.swift`
  - `PlaylistCachierError.swift`
  - `QurierError.swift`
- **DTO 모델 확장**: 다양한 데이터 전송 객체 추가

### 6. 테스트 코드 작성
- **QuerierTests**: 새로운 API 테스트 코드 작성
- **PlaylistCahingTests**: 캐싱 기능 테스트 강화

## 커밋 히스토리
1. `c467f43` - [Feat] HeadAccessDateTable 제거
2. `344f0c6` - [Feat] Querier 제작  
3. `49b3091` - [Feat] Querier Service 제작
4. `4460021` - [Feat] EndPoint 개선

## 영향도
- 데이터베이스 구조 최적화로 성능 향상
- 새로운 Query API 시스템으로 확장성 개선
- 캐싱 로직 개선으로 메모리 효율성 증대
