//
//  PublicTables.swift
//  
//
//  Created by Greem on 10/4/24.
//

import Foundation

// MARK: -- 애플 뮤직, 스포티파이 등 뮤직 플랫폼을 구분하는 테이블
/// Enum String 프로토콜을 따라서 rawValue로 DB와 값을 주고 받을 수 있습니다.
public enum MusicPlatformTypeDTO: String, Codable {
    static let name: String = "musicPlatformType"
    case apple = "Apple"
    case spotify = "Spotify"
}

// MARK: -- 사용자가 가져오는 유튜브 플레이리스트 타입을 구분하는 테이블
public enum YTPlaylistTypeDTO: String, Codable {
    case official = "Official"
    case video = "Video"
}

public enum TotalInfoTypeDTO: Codable { 
    case length(Int)
    case duration(Int)
    static func makeByPlaylistType(
        _ playlistType: YTPlaylistTypeDTO,
        num: Int
    ) -> TotalInfoTypeDTO {
        switch playlistType {
        case .official: return .length(num)
        case .video: return .duration(num)
        }
    }
}


