# QuerierResponse 타입 변경

## 작업 개요
Supabase Chart API의 응답 구조를 개선하여 더 일관성 있고 유연한 타입 시스템을 구축하는 리팩토링 작업

## 주요 변경사항

### 1. 제네릭 Response 타입 도입
- **`ChartResponse<SuccessData, FailedData>` 제네릭 구조체 추가**:
  ```swift
  public struct ChartResponse<SuccessData: Decodable, FailedData: Decodable>: Decodable {
      public let success: SuccessData?
      public let failed: FailedData?
  }
  ```
- 성공/실패 데이터를 타입 안전하게 처리할 수 있는 구조로 개선

### 2. ChartsQuerier 메서드 반환 타입 변경
- **기존 구조**: 각각 다른 Response 타입 사용
  - `ChartRecentChannelsResponse` → `[ChartResponse<RecentChannelResponse, String>]`
  - `ChartMostChannelsResponse` → `[ChartResponse<MostChannelResponse, String>]`
  - `ChartPlaylistsResponse` → `[ChartResponse<YTPlaylistHeadDTO, String>]`

- **개선된 구조**: 일관된 제네릭 배열 타입 사용
  - `getRecentChannels()`: `[ChartResponse<RecentChannelResponse, String>]`
  - `getMostChannels()`: `[ChartResponse<MostChannelResponse, String>]`
  - `getRecentPlaylists()`: `[ChartResponse<YTPlaylistHeadDTO, String>]`
  - `getMostPlaylists()`: `[ChartResponse<YTPlaylistHeadDTO, String>]`

### 3. ChannelsQuerier 타입 개선
- **`ChannelPlaylistsResposne` → `ChannelPlaylistsResponse`**:
  - 오타 수정 및 구조 개선
  - 기존: `PlaylistHeads: [YTPlaylistHeadDTO]`, `FailedPlaylistIDs: [String]`
  - 개선: `success: YTPlaylistHeadDTO?`, `failed: String?`
- **반환 타입**: `[ChannelPlaylistsResponse]` 배열로 변경

### 4. Response 모델 구조 단순화
- **제거된 타입들**:
  - `ChartMostChannelsResponse`
  - `ChartRecentChannelsResponse` 
  - `ChartPlaylistsResponse`
  - `ChannelPlaylistsResposne` (오타 포함)

- **개선된 기본 타입들**:
  - `MostChannelResponse`에 `channel_thumbnail` 필드 추가
  - `RecentChannelResponse`에 `channel_thumbnail` 필드 추가

### 5. 파일명 정정
- `ChannelsResposne.swift` → `ChannelsResponse.swift` (오타 수정)

## 기술적 장점

### 1. 타입 안전성 향상
- 제네릭을 활용한 컴파일 타임 타입 체크
- success/failed 케이스를 명확히 구분

### 2. 코드 재사용성 증대
- 하나의 제네릭 타입으로 다양한 응답 처리
- 중복 코드 제거

### 3. API 응답 구조 일관성
- 모든 차트 API가 동일한 응답 패턴 사용
- 예측 가능한 에러 처리

### 4. 확장성 개선
- 새로운 API 추가 시 기존 제네릭 타입 재사용 가능
- 유지보수성 향상

## 영향도
- **호환성**: 기존 API 사용 코드 수정 필요
- **성능**: 타입 안전성 향상으로 런타임 에러 감소
- **개발 경험**: 더 명확한 타입 정보로 개발 생산성 향상