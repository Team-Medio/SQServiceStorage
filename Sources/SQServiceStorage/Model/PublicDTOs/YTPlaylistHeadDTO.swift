//
//  YTPlaylistHeadDTO.swift
//  PlaylistCachier
//
//  Created by Greem on 11/21/24.
//

import Foundation

// MARK: -- 플리 메타데이터를 담는 DTO
public struct YTPlaylistHeadDTO: Identifiable,Codable {
    public let id: String
    public let originURL: String
    public let insertedDate: Date
    public let isShazamed: Bool
    public let thumbnailURL: String
    public let title: String
    
    public let channel: YTChannelInfoDTO
    
    public let ytPlaylistType: YTPlaylistTypeDTO
    
    // 커스텀 디코딩을 위한 CodingKeys와 init(from decoder:) 추가
    private enum CodingKeys: String, CodingKey {
        case id, originURL, insertedDate, isShazamed, thumbnailURL, title, channel, ytPlaylistType
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        originURL = try container.decode(String.self, forKey: .originURL)
        isShazamed = try container.decode(Bool.self, forKey: .isShazamed)
        thumbnailURL = try container.decode(String.self, forKey: .thumbnailURL)
        title = try container.decode(String.self, forKey: .title)
        channel = try container.decode(YTChannelInfoDTO.self, forKey: .channel)
        ytPlaylistType = try container.decode(YTPlaylistTypeDTO.self, forKey: .ytPlaylistType)
        
        // ISO 8601 날짜 문자열을 Date로 변환
        let dateString = try container.decode(String.self, forKey: .insertedDate)
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        if let date = formatter.date(from: dateString) {
            insertedDate = date
        } else {
            // 대체 포맷터 시도 (밀리초 없는 경우)
            formatter.formatOptions = [.withInternetDateTime]
            if let date = formatter.date(from: dateString) {
                insertedDate = date
            } else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "Date string does not match expected format: \(dateString)"
                    )
                )
            }
        }
    }
    
    /// id: 유튜브 영상 고유 ID 입니다.
    /// originURL: 유튜브 URLD 입니다.
    /// title: 플레이리스트 이름 입니다.
    /// channelName: 채널 이름 입니다.
    /// thumbnailURL: 썸네일 URL 입니다.
    /// isShazamed: 샤잠 처리가 되었는지 확인합니다.
    /// ytPlaylistType: 유튜브 플레이리스트 타입입니다.
    public init(
        id: String,
        originURL: String,
        title: String,
        thumbnailURL: String,
        isShazamed: Bool,
        channel: YTChannelInfoDTO,
        ytPlaylistType: YTPlaylistTypeDTO
    ) {
        self.id = id
        self.originURL = originURL
        self.insertedDate = Date()
        self.isShazamed = isShazamed
        self.thumbnailURL = thumbnailURL
        self.title = title
        self.channel = channel
        self.ytPlaylistType = ytPlaylistType
    }
    
  
}
