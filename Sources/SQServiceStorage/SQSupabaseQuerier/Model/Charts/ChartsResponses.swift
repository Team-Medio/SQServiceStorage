//
//  File.swift
//  SQServiceStorage
//
//  Created by Greem on 8/18/25.
//

import Foundation


public struct ChartResponse<SuccessData: Decodable, FailedData: Decodable>: Decodable {
    public let success: SuccessData?
    public let failed: FailedData?
}

public struct MostChannelResponse: Decodable {
    public let channel_id: String
    public let channel_name: String
    public let channel_thumbnail: String
    public let sqoop_count: Int
}

public struct RecentChannelResponse: Decodable {
    public let channel_id: String
    public let channel_name: String
    public let channel_thumbnail: String
}
