//
//  File.swift
//  SQServiceStorage
//
//  Created by Greem on 8/18/25.
//

import Foundation
import Testing
@testable import SQServiceStorage

@Suite("SqoopsAPI")
struct SqoopsAPI {
    let sqoopsQuerier = SqoopsQuerier(
        supabaseURL: URL(string: SUPABASE_URL)!,
        supabaseKey: ANON_KEY
    )
    @Test func logAppend() async throws {
        do {
            try await sqoopsQuerier.appendPlaylistLog(playlistID: "Test", channelID: "Test")
        } catch {
            print(error)
        }
    }
}
