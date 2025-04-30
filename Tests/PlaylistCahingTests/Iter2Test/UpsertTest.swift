//
//  File.swift
//  PlaylistCachier
//
//  Created by Greem on 11/7/24.
//

import Testing
@testable import SQServiceStorage



extension Iter2 {
    func runUpsertTest() async throws{
        let arguments = [
            YTPlaylistDTO(
                head: .init(
                    id: "sadfsdafsad",
                    originURL: "zxcvxczxcv",
                    title: "안녕하세요",
                    thumbnailURL: "ㅋㅋㅋㅋㅋ",
                    isShazamed: false,
                    channel: .init(id: "sadfasdf", name: "xvzxcvzx"),
                    ytPlaylistType: .official
                ),
                totalInfo: 320,
                musicPlatform: .apple,
                musicInfos: [
                    .init(platformKey: "xczzxcv", isrc: "cxzvrger"),
                    .init(platformKey: "xcverqrt", isrc: "oerpqoire")
                ],
                startTime: [1,2]
            )
          ]
        for argument in arguments {
            try await upsertPlaylistTest(argument)
        }
    }
    func upsertPlaylistTest(_ data: YTPlaylistDTO) async throws {
        try await cachier.upsertPlaylist(data)
    }
}
