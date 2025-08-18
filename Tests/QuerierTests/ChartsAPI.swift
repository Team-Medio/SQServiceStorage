//
//  ChartsAPI.swift
//  SQServiceStorage
//
//  Created by Greem on 8/18/25.
//

import Foundation
import Testing
@testable import SQServiceStorage

@Suite("차트 API")
struct ChartsAPITest {
    
    let querier: ChartsQuerier = .init(
        supabaseURL: URL(string: SUPABASE_URL)!,
        supabaseKey: ANON_KEY
    )
    
    @Test
    func getRecentPlaylists() async throws {
        let sut = try await querier.getRecentPlaylists(limitCount: 5)
        print(sut)
    }
    
    @Test
    func getRecentChannels() async throws {
        let sut = try await querier.getRecentChannels(limitCount: 5)
        print(sut)
    }
    
    @Test func getWeeklyMostPlaylists() async throws {
        let sut = try await querier.getMostPlaylists(period: .week, date: .now, limitCount: 5)
        print(sut)
    }
    
    @Test func getWeeklyMostChannels() async throws {
        let oneDayInSeconds: TimeInterval = 60 * 60 * 24
        let thirtyDaysInSeconds = oneDayInSeconds * 30
        let sut = try await querier.getMostChannels(period: .week, date: .now.addingTimeInterval(-thirtyDaysInSeconds), limitCount: 5)
        print(sut)
    }
}
