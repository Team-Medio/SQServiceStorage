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
    
//    let querier: ChannelsQuerier = .init(
//        supabaseURL: <#T##URL#>,
//        supabaseKey: <#T##String#>
//    )
    
    @Test
    func getPlaylists() async throws {
//        let res = try await querier.getPlaylists(channelID: <#T##String#>, limitCount: 10)
//        print(res)
    }
    @Test
    func testMyFunctionWithSecretKey() {
        

        // 이제 apiKey 변수를 테스트 로직에 사용
        print("apikey: \(Hello)")
//        let myService = MyService(apiKey: apiKey)
//        XCTAssertTrue(myService.isInitialized)
    }
}
