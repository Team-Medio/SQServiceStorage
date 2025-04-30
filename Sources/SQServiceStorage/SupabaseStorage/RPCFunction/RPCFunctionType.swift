//
//  File.swift
//  SQServiceStorage
//
//  Created by Greem on 11/22/24.
//

import Foundation

enum RPCFunctionType: String, Codable {
    case getHeads = "getheads"
    case getTotalSongsCount = "gettotalsongcount"
    case getTotalPlaylistsCount = "gettotalplaylistcount"
    case playlistAccessByDateDESC = "playlistaccessbydatedesc"
    case getIsShazamed = "get_is_shazamed"
}
