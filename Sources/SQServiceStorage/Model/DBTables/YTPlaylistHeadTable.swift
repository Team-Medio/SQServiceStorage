//
//  YTPlaylistHeadTable.swift
//  PlaylistCachier
//
//  Created by Greem on 11/21/24.
//

import Foundation

struct YTPlaylistHeadTable: Codable {
    let id: String
    let originURL:String
    let title:String
    var channelID: String
    let thumbnailURLString: String
    let insertedDate:Date
    let isShazamed: Bool
    let playlistType: YTPlaylistTypeDTO.RawValue
    init(id: String,
         originURL: String,
         title: String,
         channelID: String,
         thumbnailURLString: String,
         insertedDate: Date,
         isShazamed: Bool,
         playlistType: YTPlaylistTypeDTO.RawValue) {
        self.id = id
        self.originURL = originURL
        self.title = title
        self.channelID = channelID
        self.thumbnailURLString = thumbnailURLString
        self.insertedDate = insertedDate
        self.isShazamed = isShazamed
        self.playlistType = playlistType
    }
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.originURL = try container.decode(String.self, forKey: .originURL)
        self.title = try container.decode(String.self, forKey: .title)
        self.channelID = try container.decode(String.self, forKey: .channelID)
        self.thumbnailURLString = try container.decode(String.self, forKey: .thumbnailURLString)
        let date = try container.decode(String.self, forKey: .insertedDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXX"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        guard let insertedDate = dateFormatter.date(from: date) else {
            throw PlaylistCachierError.dateConvertFailed
        }
        self.insertedDate = insertedDate
        self.isShazamed = try container.decode(Bool.self, forKey: .isShazamed)
        self.playlistType = try container.decode(YTPlaylistTypeDTO.RawValue.self, forKey: .playlistType)
    }
    
}
