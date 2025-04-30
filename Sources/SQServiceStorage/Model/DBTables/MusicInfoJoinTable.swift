//
//  MusicInfoJoinTable.swift
//  PlaylistCachier
//
//  Created by Greem on 11/21/24.
//

import Foundation

struct MusicInfoJoinTable: Codable {
    let id: String
    let musicPlatformType: MusicPlatformTypeDTO.RawValue
    let musicKey: String
    let idx: Int
    let ISRC: String
}
