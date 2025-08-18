//
//  File.swift
//  SQServiceStorage
//
//  Created by Greem on 8/18/25.
//

import Foundation

public final class ChannelsQuerier: SQSupabaseQuerier {
    public override init(supabaseURL: URL, supabaseKey: String) {
        super.init(supabaseURL: supabaseURL, supabaseKey: supabaseKey)
    }
    
    public func getPlaylists(channelID: String, limitCount: Int) async throws -> ChannelPlaylistsResposne {
        let endPoint = ChannelsEndPoint.playlists(channelID: channelID, limitCount: limitCount)
        let request = endPoint.getURLRequest(baseUrl: self.supabaseURL, supabaseKey: self.supabaseKey)
        guard let (data, _ ) = try? await URLSession.shared.data(for: request),
              let channelPlaylistsResponse = try? data.convertToTable(type: ChannelPlaylistsResposne.self) else {
            throw NetworkingError.DataConvertFailed
        }
        return channelPlaylistsResponse
    }
}


