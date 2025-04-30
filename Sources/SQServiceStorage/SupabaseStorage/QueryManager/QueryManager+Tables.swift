//
//  QueryManager+Tables.swift
//  PlaylistCachier
//
//  Created by Greem on 11/11/24.
//

import Foundation
import Supabase

extension QueryManager {
    
    func getPlaylistHeadTable(
        id: String
    ) async throws -> YTPlaylistHeadTable{
        try await clientSafety { client in
            try await client.ytPlaylistHeadTable
                .select("*").eq("id", value: id)
                .single().execute().data
                .convertToTable(type: YTPlaylistHeadTable.self)
        }
    }
    
    func getYTOfficialPlaylistTable(
        id: String,
        platformType: MusicPlatformTypeDTO = .apple
    ) async throws -> YTOfficialPlaylistTable {
        try await clientSafety { client in
            try await client
                .ytOfficialPlaylistTable.select("*")
                .eq("id", value: id)
                .eq("musicPlatformType", value: platformType.rawValue)
                .single().execute()
                .data.convertToTable(type: YTOfficialPlaylistTable.self)
        }
    }
    
    func getYTVideoPlaylistTable(
        id:String,
        platformType: MusicPlatformTypeDTO = .apple)
    async throws -> YTVideoPlaylistTable{
        try await clientSafety { client in
            try await client
                .ytVideoPlaylistTable.select("*")
                .eq("id", value: id)
                .eq("musicPlatformType", value: platformType.rawValue)
                .single().execute()
                .data.convertToTable(type: YTVideoPlaylistTable.self)
        }
    }
    func getYTChannelInfoTable(
        id:String
    ) async throws -> YTChannelInfoDTO {
        try await clientSafety { client in
            try await client
                .ytChannelInfoTable.select("*")
                .eq("id", value: id)
                .single().execute()
                .data.convertToTable(type: YTChannelInfoDTO.self)
        }
    }
}

