//
//  PlaylistHeadAccessDateTable.swift
//  PlaylistCachier
//
//  Created by Greem on 11/21/24.
//

import Foundation

struct PlaylistHeadAccessDateTable: Codable {
    let id: String
    let access: Date
    
    init(id: String) {
        self.id = id
        self.access = Date()
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        let date = try container.decode(String.self, forKey: .access)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXX"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        guard let accessDate = dateFormatter.date(from: date) else {
            throw PlaylistCachierError.dateConvertFailed
        }
        self.access = accessDate
    }
}
