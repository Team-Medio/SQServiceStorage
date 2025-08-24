//
//  ChannelPlaylistsResposne.swift
//  SQServiceStorage
//
//  Created by Greem on 8/18/25.
//

import Foundation

public struct ChannelPlaylistsResponse: Decodable {
    public let success: YTPlaylistHeadDTO?
    public let failed: String?
}

