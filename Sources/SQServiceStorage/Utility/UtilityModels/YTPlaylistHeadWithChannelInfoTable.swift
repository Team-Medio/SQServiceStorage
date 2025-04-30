//
//  YTPlaylistHeadWithChannelInfoTable.swift
//  SQServiceStorage
//
//  Created by Greem on 11/22/24.
//

import Foundation

struct YTPlaylistHeadWithChannelInfoTable: Codable {
    let id: String
    let originURL:String
    let title:String
    let thumbnailURLString: String
    let insertedDate:Date
    let isShazamed: Bool
    let playlistType: YTPlaylistTypeDTO.RawValue
    var channelID: String
    let channelName: String
    
    init(from decoder: any Decoder) throws {
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
        guard let insertedDate: Date = dateFormatter.date(from: date) else {
            throw PlaylistCachierError.dateConvertFailed
        }
        self.insertedDate = insertedDate
        self.isShazamed = try container.decode(Bool.self, forKey: .isShazamed)
        self.playlistType = try container.decode(YTPlaylistTypeDTO.RawValue.self, forKey: .playlistType)
        self.channelID = try container.decode(String.self, forKey: .channelID)
        self.channelName = try container.decode(String.self, forKey: .channelName)
    }
    
    var convertToYTPlaylistHead: YTPlaylistHeadDTO {
        .init(
            id: id,
            originURL: originURL,
            title: title,
            thumbnailURL: thumbnailURLString,
            isShazamed: isShazamed,
            channel: YTChannelInfoDTO(id: channelID, name: channelName),
            ytPlaylistType: .init(rawValue: playlistType)!
        )
    }
}
