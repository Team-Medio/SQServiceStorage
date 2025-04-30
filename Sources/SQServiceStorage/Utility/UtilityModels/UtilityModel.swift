//
//  File.swift
//  PlaylistCachier
//
//  Created by Greem on 11/11/24.
//

import Foundation

struct VideoPlaylistTotalInfo: Codable {
    let playLength: Int
}
struct OfficialPlaylistInfo: Codable {
    let totalSongCount: Int
}

struct HeadPlaylistInfo: Codable {
    let playlistType: YTPlaylistTypeDTO
    let id: String
    let originURL: String
}
