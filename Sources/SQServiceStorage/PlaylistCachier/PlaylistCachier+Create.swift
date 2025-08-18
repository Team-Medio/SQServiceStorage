//
//  File.swift
//  PlaylistCachier
//
//  Created by Greem on 11/13/24.
//

import Foundation
import Supabase


// MARK: -- Append method들
extension PlaylistCachier {
    // 플리 데이터 넣는 메서드
    func insertPlaylistData(
        metaDataID playlistMetaDataID: String,
        _ playlistData: YTPlaylistBodyDTO
    ) async throws {
        guard let client else { throw PlaylistCachierError.clientKeyNotEntered }
        guard !playlistData.musicInfos.isEmpty else { throw PlaylistCachierError.playlistNotExist }
        let musicInfoJoinList: [MusicInfoJoinTable] = playlistData.musicInfos
            .enumerated().map { (idx, val) in
                .init(id: playlistMetaDataID,
                      musicPlatformType: playlistData.musicPlatform.rawValue,
                      musicKey: val.platformKey,
                      idx: idx,
                      ISRC: val.isrc)
        }
        let totalInfo: Int = switch playlistData.totalInfo {
            case .duration(let info), .length(let info): info
        }
        
        switch playlistData.ytPlaylistType {
        case .official:
            let ytOfficialPlaylistTable = YTOfficialPlaylistTable(
                id: playlistMetaDataID,
                totalSongCount: totalInfo,
                musicPlatformType: playlistData.musicPlatform.rawValue
            )
            try await client.ytOfficialPlaylistTable.upsert(ytOfficialPlaylistTable).execute()
            try await client.musicInfoJoinTable.upsert(musicInfoJoinList).execute()
            
        case .video:
            /// 음악 시작 시간을 인덱싱하여 기록하는 테이블
            let musicStartJoinList: [MusicStartJoinTable] = playlistData.startTimes!
                .enumerated().map{ (idx,val) in
                    MusicStartJoinTable(id: playlistMetaDataID, idx: idx, startTime: val)
            }
            
            let ytVideoPlaylistTable = YTVideoPlaylistTable(
                id: playlistMetaDataID,
                playLength: totalInfo,
                musicPlatformType: playlistData.musicPlatform.rawValue
            )
            
            
            try await client.ytVideoPlaylistTable.upsert(ytVideoPlaylistTable).execute()
            try await client.musicInfoJoinTable.upsert(musicInfoJoinList).execute()
            try await client.musicStartJoinTable.upsert(musicStartJoinList).execute()
        }
    }
    /// 메타 데이터와 플리 데이터를 같이 넣는 메서드
    public func upsertPlaylist(_ data: YTPlaylistDTO) async throws {
        guard let client else { throw PlaylistCachierError.clientKeyNotEntered }

        let headData: YTPlaylistHeadDTO = data.head
        let headDataTable = YTPlaylistHeadTable(headDTO: headData)
        let channelInfo = headData.channel
        
        // 샤잠이 되어서 이전 것을 지워야하는 테이블
        if headDataTable.isShazamed {
            try? await deletePlaylistBody(
                id: headData.id,
                playlistType: headData.ytPlaylistType
            )
        }
        
        // 메타데이터 테이블 upsert
        try await client.ytPlaylistHeadTable.upsert(headDataTable).execute()
        
        try await withThrowingTaskGroup(of: Void.self) { group in
            group.addTask {
                try await client.ytChannelInfoTable.upsert(channelInfo).execute()
            }
            
            group.addTask {
                // 전체 플레이리스트 테이블 upsert
                try await self.insertPlaylistData(
                    metaDataID: data.head.id,
                    data.body
                )
            }
            try await group.waitForAll()
        }
    }
}
