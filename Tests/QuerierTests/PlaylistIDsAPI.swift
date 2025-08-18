//
//  File.swift
//  SQServiceStorage
//
//  Created by Greem on 2/17/25.
//

import Foundation
import Testing
@testable import SQServiceStorage
import XCTest


final class QurierTest: XCTestCase{
    let playlistQuerier = PlaylistQuerier(supabaseURL: .init(string:"")!,
                                          supabaseKey: "")
    

    func testExample() async throws {
//        let recentIds = try await playlistQuerier.getIDsByAccessDateDESC(limit: 20)
//        let weeklyMostids = try await playlistQuerier.getIDsByWeeklyMostCountsDESC(date: Date.now, limit: 10)
//        try await playlistQuerier.appendPlaylistLog(playlistID: "hello temp");
//        print("recent: \(recentIds)")
//        print("weekly: \(weeklyMostids)")
    }
}
