//
//  QueryManager+ListModel.swift
//  PlaylistCachier
//
//  Created by Greem on 11/11/24.
//

import Foundation
import Supabase

extension QueryManager {
    func getMusicInfoList(id: String, musicPlatformType: MusicPlatformTypeDTO = .apple) async throws -> [MusicInfoTableDTO] {
        guard let client else{ throw PlaylistCachierError.clientKeyNotEntered }
        return try await client.musicInfoJoinTable
            .select("*").eq("id", value: id).eq("musicPlatformType", value: musicPlatformType.rawValue)
            .execute().data.convertToTable(type: [MusicInfoJoinTable].self)
            .sorted { $0.idx < $1.idx }.map{ MusicInfoTableDTO(platformKey: $0.musicKey, isrc: $0.ISRC) }
    }
    
    /// 순서 기반으로 시작시간을 가져오는 메서드
    func getMusicStartTimeList(id: String) async throws -> [Int] {
        guard let client else{ throw PlaylistCachierError.clientKeyNotEntered }
        return try await client.musicStartJoinTable
            .select("*")
            .eq("id",value: id)
            .execute().data
            .convertToTable(type: [MusicStartJoinTable].self)
            .sorted { $0.idx < $1.idx }.map{ $0.startTime }
    }
}
