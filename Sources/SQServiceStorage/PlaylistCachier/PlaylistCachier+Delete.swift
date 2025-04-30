//
//  PlaylistCachier+Delete.swift
//  PlaylistCachier
//
//  Created by Greem on 11/13/24.
//

import Foundation
import Supabase
// MARK: --  Delete method 들
extension PlaylistCachier {
    // Delete 정책
    // 1. playlist를 지우면 메타데이터 - 음악 테이블 둘 다 지운다.
    // 2. playlistData를 지우면 음악 데이터 테이블을 지운다.
    /// 플레이리스트 메타데이터는 그대로 두고 음악 데이터 테이블만 지우는 메서드
    func deletePlaylistBody(id: String,
                                    playlistType: YTPlaylistTypeDTO) async throws {
        guard let client else{ throw PlaylistCachierError.clientKeyNotEntered }
        
        let tableBuilder: PostgrestQueryBuilder = switch playlistType {
            case .official: client.ytOfficialPlaylistTable
            case .video: client.ytVideoPlaylistTable
        }
        
        try await withThrowingTaskGroup(of: Void.self) { group in
            group.addTask { try await tableBuilder.delete().eq("id", value: id).execute() }
            group.addTask { try await client.musicInfoJoinTable.delete().eq("id", value: id).execute() }
            if case(.video) = playlistType {
                group.addTask { try await client.musicStartJoinTable.delete().eq("id", value: id).execute() }
            }
            try await group.waitForAll()
        }
    }
    
    // 플레이리스트 전체 정보를 삭제함 => 날짜가 일정부분(한 달 이상) 지났을 때 진행함
    func deletePlaylist(
        id: String,
        playlistType: YTPlaylistTypeDTO
    ) async throws {
        guard let client else{ throw PlaylistCachierError.clientKeyNotEntered }
        try await withThrowingTaskGroup(of: Void.self) { group in
            group.addTask { try await self.deletePlaylistBody(id: id, playlistType: playlistType) }
            group.addTask { try await client.ytPlaylistHeadTable.delete().eq("id", value: id).execute() }
            try await group.waitForAll()
        }
    }
}
