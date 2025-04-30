//
//  YTVideoPlaylistTable.swift
//  PlaylistCachier
//
//  Created by Greem on 11/21/24.
//

import Foundation

struct YTVideoPlaylistTable: Codable {
    let id: String
    let playLength: Int
    let musicPlatformType: MusicPlatformTypeDTO.RawValue
}
