//
//  File.swift
//  PlaylistCachier
//
//  Created by Greem on 11/21/24.
//

import Foundation

// MARK: -- 음악 정보 키값들을 전송하는 테이블
/// platformKey: 플랫폼에 저장된 고유 노래 키
/// ISRC: 국제 협약 고유 노래 키


public struct MusicInfoTableDTO: Codable {
    public let platformKey: String
    public let isrc: String
    
    public init(platformKey: String, isrc: String) {
        self.platformKey = platformKey
        self.isrc = isrc
    }
}
