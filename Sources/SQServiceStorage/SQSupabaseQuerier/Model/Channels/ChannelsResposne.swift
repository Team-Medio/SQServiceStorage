//
//  ChannelPlaylistsResposne.swift
//  SQServiceStorage
//
//  Created by Greem on 8/18/25.
//

import Foundation

public struct ChannelPlaylistsResposne: Decodable {
    public let PlaylistHeads: [YTPlaylistHeadDTO]
    public let FailedPlaylistIDs: [String]
}
