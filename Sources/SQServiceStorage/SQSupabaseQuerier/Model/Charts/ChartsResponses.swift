//
//  File.swift
//  SQServiceStorage
//
//  Created by Greem on 8/18/25.
//

import Foundation

public struct MostChannelResponse: Decodable {
    public let channel_id: String
    public let channel_name: String
    public let sqoop_count: Int
}

public struct ChartMostChannelsResponse: Decodable {
    public let MostChannelResponses: [MostChannelResponse]
    public let FailedChannelIDs: [String]
}

public struct RecentChannelResponse: Decodable {
    public let channel_id: String
    public let channel_name: String
}

public struct ChartRecentChannelsResponse: Decodable {
    public let RecentChannelResponses: [RecentChannelResponse]
    public let FailedChannelIDs: [String]
}

public struct ChartPlaylistsResponse: Decodable {
    public let PlaylistHeads: [YTPlaylistHeadDTO]
    public let FailedPlaylistIDs: [String]
}
