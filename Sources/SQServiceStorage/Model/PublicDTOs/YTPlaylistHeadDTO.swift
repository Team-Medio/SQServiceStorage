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
    public let insertedDate:Date
    public let isShazamed: Bool
    public let thumbnailURL: String
    public let title:String
    
    public let channel: YTChannelInfoDTO
    
    public let ytPlaylistType: YTPlaylistTypeDTO
    
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
