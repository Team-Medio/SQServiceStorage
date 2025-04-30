//
//  YTOfficialPlaylistTable.swift
//  PlaylistCachier
//
//  Created by Greem on 11/21/24.
//

import Foundation

struct YTOfficialPlaylistTable: Codable {
    let id: String
    let totalSongCount: Int
    let musicPlatformType: MusicPlatformTypeDTO.RawValue
}
