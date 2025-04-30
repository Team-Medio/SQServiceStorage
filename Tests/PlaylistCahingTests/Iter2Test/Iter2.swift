//
//  Iter2.swift
//  PlaylistCachier
//
//  Created by Greem on 11/7/24.
//

import XCTest
@testable import SQServiceStorage

final class Iter2: XCTestCase {
    let cachier = PlaylistCachier(supabaseURL: .init(string: SUPAURL)!, anonKey: ANONKEY)
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() async throws {
        try await runUpsertTest()
//        try await runGetTest()
//        try await createAndGetOverDate()
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

