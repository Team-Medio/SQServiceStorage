//
//  File.swift
//  PlaylistCachier
//
//  Created by Greem on 11/21/24.
//

import Foundation

// MARK: -- 유튜브 플레이리스트 전체 정보 DTO
public struct YTPlaylistDTO {
    public let head: YTPlaylistHeadDTO
    public let body: YTPlaylistBodyDTO
    
    /// 메타데이터와 PlaylistData 둘 존재하는 경우 사용합니다.
    public init(head: YTPlaylistHeadDTO,
                body: YTPlaylistBodyDTO
    ) {
        self.head = head
        self.body = body
    }
}
public extension YTPlaylistDTO {
    init(
        head: YTPlaylistHeadDTO,
        totalInfo: Int,
        musicPlatform: MusicPlatformTypeDTO,
        musicInfos: [MusicInfoTableDTO],
        startTime: [Int]?
    ) {
        self.init(
            head: head,
            body: .init(
                originURL: head.originURL,
                ytPlaylistType: head.ytPlaylistType,
                musicPlatform: musicPlatform,
                totalInfo: totalInfo,
                musicInfos: musicInfos,
                startTimes: startTime
            )
        )
    }
}
