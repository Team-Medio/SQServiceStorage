//
//  ChannelsAPI.swift
//  SQServiceStorage
//
//  Created by Greem on 8/18/25.
//

import Foundation
import Testing
@testable import SQServiceStorage

@Suite("채널 API")
struct ChannelsAPITest {
    let querier: ChannelsQuerier = .init(
        supabaseURL: URL(string: SUPABASE_URL)!,
        supabaseKey: ANON_KEY
    )
    
    @Test func getPlaylists() async throws {
        let res = try await querier.getPlaylists(channelID: "UCjmZi4wQOrIKhDBn4nDyPLw", limitCount: 1)
        print(res)
    }
    
}

