//
//  File.swift
//  PlaylistCachier
//
//  Created by Greem on 11/11/24.
//

import Foundation

extension YTPlaylistHeadTable {
    init(headDTO dto: YTPlaylistHeadDTO) {
        self.init(
            id: dto.id,
            originURL: dto.originURL,
            title: dto.title,
            channelID: dto.channel.id,
            thumbnailURLString: dto.thumbnailURL,
            insertedDate: dto.insertedDate,
            isShazamed: dto.isShazamed,
            playlistType: dto.ytPlaylistType.rawValue
        )
    }
}
extension YTPlaylistHeadDTO {
    init(headTable headData: YTPlaylistHeadTable,channelTable: YTChannelInfoDTO) {
        self.init(
            id: headData.id,
            originURL: headData.originURL,
            title: headData.title,
            thumbnailURL: headData.thumbnailURLString,
            isShazamed: headData.isShazamed,
            channel: channelTable,
            ytPlaylistType: YTPlaylistTypeDTO(rawValue: headData.playlistType)!
        )
    }
}
