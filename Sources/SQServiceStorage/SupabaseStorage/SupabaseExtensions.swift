//
//  SupabaseExtensions.swift
//  PlaylistCachier
//
//  Created by Greem on 10/7/24.
//

import Foundation
import Supabase

// MARK: -- 캐싱 관련 Extension
extension SupabaseClient{
    var originalPlayListMusickKeyJoinTable: PostgrestQueryBuilder { self.from("OriginalPlayListMusicJoin") }
    
    var musicInfoJoinTable: PostgrestQueryBuilder { self.from("MusicInfoJoin") }
    var musicStartJoinTable: PostgrestQueryBuilder { self.from("MusicStartJoin") }
    
    var ytOfficialPlaylistTable: PostgrestQueryBuilder { self.from("YTOfficialPlaylist") }
    var ytVideoPlaylistTable: PostgrestQueryBuilder { self.from("YTVideoPlaylist") }
    
    var ytChannelInfoTable: PostgrestQueryBuilder { self.from("YTChannelInfo") }
    
    var ytPlaylistHeadTable: PostgrestQueryBuilder { self.from("YTPlaylistHead") }
    
}

extension SupabaseClient {
    var metadataAccessDate: PostgrestQueryBuilder { self.from("PlaylistHeadAccessDate") }
}

extension PostgrestFilterBuilder {
    func convertToTable<T>(type: T.Type) async throws -> T where T: Decodable {
        let data = try await self.execute().data
        return try JSONDecoder().decode(type, from: data)
    }
}
