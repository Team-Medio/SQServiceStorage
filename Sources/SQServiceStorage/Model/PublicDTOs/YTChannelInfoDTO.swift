//
//  File.swift
//  PlaylistCachier
//
//  Created by Greem on 11/22/24.
//

import Foundation

public struct YTChannelInfoDTO: Codable {
    public let id: String
    public let name: String
    public var subscribers: Int = 0
    public var thumbnailURLString: String = ""
    
    public init(
        id: String,
        name: String,
        subscribers: Int = 0,
        thumbnailURLString: String = ""
    ) {
        self.id = id
        self.name = name
    }
    
}
