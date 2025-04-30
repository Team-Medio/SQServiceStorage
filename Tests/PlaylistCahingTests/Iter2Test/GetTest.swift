//
//  File.swift
//  PlaylistCachier
//
//  Created by Greem on 11/7/24.
//

import Testing
@testable import SQServiceStorage

extension Iter2 {
    
    /// 가져오기 실행하는 테이블
    func runGetTest() async throws {
        let ids: [String] = ["sadfsdafsad","wow"]
        for id in ids {
            do {
                print("---- GetPlaylistMetaData ----")
//                dump(try await cachier.getPlaylistMetaData(id: id))
                print("---- GetPlaylistData ----")
//                dump(try await cachier.getPlaylistData(id: id))
                print("---- GetPlaylist ----")
                dump(try await cachier.getPlaylist(id: id))
            }catch {
                print("넘어갑니다!! \(error)" )
            }
        }
    }
    
    /// 한 달을 넘겼으면 삭제 시키는 테이블
//    func createAndGetOverDate() async throws {
//        do {
//            try await cachier.upsertPlaylist(
//                .init(
//                    metaData:
//                            .init(
//                                id: "google",
//                                originURL: "www.gogogo.com",
//                                title: "gogogo",
//                                thumbnailURL: "sdfadf",
//                                isShazamed: false,
//                                channel: .init(id: "nate", name: "erogoqer"),
//                                ytPlaylistType: .official
//                                ),
//                    totalInfo: 26,
//                    musicPlatform: .apple,
//                    musicInfos: [.init(platformKey: "xcvzxcv", ISRC: "qwerqwer")],
//                    startTime: [0]
//                )
//            )
//            let res = try await cachier.getPlaylist(id: "google")
//            print(res)
//        }catch{
//            print(error)
//        }
//    }
}
