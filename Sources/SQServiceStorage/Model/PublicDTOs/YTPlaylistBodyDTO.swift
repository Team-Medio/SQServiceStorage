//
//  File.swift
//  PlaylistCachier
//
//  Created by Greem on 11/21/24.
//

import Foundation

// MARK: -- 플레이리스트 정보를 담는 DTO
public struct YTPlaylistBodyDTO: Codable {
    public let originURL: String // 유튜브 URL
    public let ytPlaylistType: YTPlaylistTypeDTO // 플레이리스트 타입
    public let musicPlatform: MusicPlatformTypeDTO // 음악 플랫폼
    public let totalInfo: TotalInfoTypeDTO
    public let musicInfos: [MusicInfoTableDTO]
    public let startTimes: [Int]?
    
    /// originURL: 유튜브 URL 입니다.
    /// ytPlaylistType: 플레이리스트 타입입니다. - official, video
    /// musicPlatform: 음악 플랫폼 입니다. - apple, spotify
    /// musicInfos: 음악 정보가 들은 배열입니다.
    /// startTimes: 음악의 시작 시간 들어있는 배열입니다. - video에서 사용
    public init(
        originURL: String,
        ytPlaylistType: YTPlaylistTypeDTO,
        musicPlatform: MusicPlatformTypeDTO = .apple,
        totalInfo: Int,
        musicInfos: [MusicInfoTableDTO],
        startTimes: [Int]? = nil
    ) {
        self.originURL = originURL
        self.ytPlaylistType = ytPlaylistType
        self.totalInfo = .makeByPlaylistType(ytPlaylistType, num: totalInfo)
        self.musicPlatform = musicPlatform
        self.musicInfos = musicInfos
        self.startTimes = startTimes
    }
}
