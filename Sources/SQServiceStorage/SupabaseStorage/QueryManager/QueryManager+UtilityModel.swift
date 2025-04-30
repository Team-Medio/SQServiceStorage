//
//  QueryManager+UtilityModel.swift
//  PlaylistCachier
//
//  Created by Greem on 11/11/24.
//

import Foundation
import Supabase

extension QueryManager {
    
    func getHeadPlaylistInfo(id: String) async throws -> HeadPlaylistInfo {
        try await clientSafety { client in
            try await client.ytPlaylistHeadTable
                .select("playlistType,id,originURL").eq("id", value: id)
                .single().execute()
                .data.convertToTable(type: HeadPlaylistInfo.self)
        }
    }
    
    func getTotalSongCount(id: String) async throws -> Int {
        try await clientSafety { client in
            try await client.ytOfficialPlaylistTable
                .select("totalSongCount").eq("id", value: id)
                .single().execute()
                .data.convertToTable(type: OfficialPlaylistInfo.self)
                .totalSongCount
        }
    }
    
    func getPlayLenght(id: String) async throws -> Int {
        try await clientSafety { client in
            try await client.ytVideoPlaylistTable
                .select("playLength").eq("id", value: id)
                .single().execute()
                .data.convertToTable(type: VideoPlaylistTotalInfo.self)
                .playLength
        }
    }
}
