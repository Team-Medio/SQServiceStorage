//
//  File.swift
//  PlaylistCachier
//
//  Created by Greem on 11/13/24.
//

import Foundation
import Supabase

fileprivate extension PlaylistCachier {
    func getAction<T>(id:String ,action: @escaping (() async throws->(T))) async throws -> T{
        // 여기에 get 이전에 처리할 작업을 넣을 수 있다.
        try await client?.metadataAccessDate.upsert(PlaylistHeadAccessDateTable(id: id)).execute()
        let val = try await action()
        // 여기에 get 이후에 처리할 작업을 넣을 수 있다.
        return val
    }
}

// MARK: -- Get method들
extension PlaylistCachier {
    
    /// 메타데이터, 데이터의 플레이리스트 전체 정보를 제공하는 메서드입니다.
    public func getPlaylist(
        id: String,
        musicPlatformType: MusicPlatformTypeDTO = .apple
    ) async throws -> YTPlaylistDTO {
        try await getAction(id: id) { [weak self] in
            guard let self else { throw PlaylistCachierError.unknwonGetFailed }
            let playlistHeadTable: YTPlaylistHeadTable  = try await queryManager.getPlaylistHeadTable(id: id)
            // 한 달 전이면 제거함
            if playlistHeadTable.insertedDate.isOverOneMonthAgo {
                try await deletePlaylist(id: id,playlistType: YTPlaylistTypeDTO(rawValue: playlistHeadTable.playlistType)!)
                throw PlaylistCachierError.overOneMonth
            }
            
            let channelInfoDTO:YTChannelInfoDTO = try await queryManager.getYTChannelInfoTable(id: playlistHeadTable.channelID)
            let musicInfoList:[MusicInfoTableDTO] = try await queryManager.getMusicInfoList(id: id)
            let headDTO:YTPlaylistHeadDTO = YTPlaylistHeadDTO(headTable: playlistHeadTable, channelTable: channelInfoDTO)
            
            
            switch YTPlaylistTypeDTO(rawValue: playlistHeadTable.playlistType)! {
            case .official:
                let officialPlaylistTable = try await queryManager.getYTOfficialPlaylistTable(id: id)
                
                let playlistDTO = YTPlaylistBodyDTO(
                    originURL: playlistHeadTable.originURL,
                    ytPlaylistType: YTPlaylistTypeDTO(rawValue: playlistHeadTable.playlistType)!,
                    musicPlatform: musicPlatformType,
                    totalInfo: officialPlaylistTable.totalSongCount,
                    musicInfos: musicInfoList)
                  
                return YTPlaylistDTO(
                    head: headDTO,
                    body: playlistDTO
                )
            case .video:
                
                let videoPlaylistTable: YTVideoPlaylistTable = try await queryManager.getYTVideoPlaylistTable(id: id)
                
                async let startTimeList = try queryManager.getMusicStartTimeList(id: videoPlaylistTable.id)
                
                let playlistDTO = try await YTPlaylistBodyDTO(
                    originURL: playlistHeadTable.originURL,
                    ytPlaylistType: YTPlaylistTypeDTO(
                        rawValue: playlistHeadTable.playlistType
                    )!,
                    musicPlatform: musicPlatformType,
                    totalInfo: videoPlaylistTable.playLength,
                    musicInfos: musicInfoList,
                    startTimes: startTimeList
                )
                
                
                return YTPlaylistDTO(
                    head: headDTO,
                    body: playlistDTO
                )
            }
        }
    }
    
    
    /// 헤더 정보만 제공하는 메서드입니다.
    public func getPlaylistHead(
        id: String,
        musicPlatformType: MusicPlatformTypeDTO = .apple
    ) async throws -> YTPlaylistHeadDTO {
        try await getAction(id: id) {[weak self] in
            guard let self else { throw PlaylistCachierError.unknwonGetFailed }
            
            let playlistHeadTable = try await queryManager.getPlaylistHeadTable(id: id)
            let channelDTO = try await queryManager.getYTChannelInfoTable(id: playlistHeadTable.channelID)
            // 한 달 전이면 제거함
            if playlistHeadTable.insertedDate.isOverOneMonthAgo {
                try await deletePlaylist(
                    id: id,
                    playlistType: YTPlaylistTypeDTO(rawValue: playlistHeadTable.playlistType)!
                )
                throw PlaylistCachierError.overOneMonth
            }
            
            return YTPlaylistHeadDTO(headTable: playlistHeadTable, channelTable: channelDTO)
        }
    }
    
    /// 플레이리스트 데이터 정보만 제공하는 메서드입니다.
    public func getPlaylistBody(
        id: String,
        musicPlatformType: MusicPlatformTypeDTO = .apple
    ) async throws -> YTPlaylistBodyDTO {
        try await getAction(id: id) { [weak self] in
            guard let self else { throw PlaylistCachierError.unknwonGetFailed }
            // 메타 데이터 정보를 찾지 못하면 초기화합니다.
            guard let metaPlaylistInfo:HeadPlaylistInfo = try? await queryManager.getHeadPlaylistInfo(id: id) else {
                throw PlaylistCachierError.metaDataNotFound
            }
            async let musicInfoList = try await queryManager.getMusicInfoList(id: id)
            async let startTimes:[Int]? = switch metaPlaylistInfo.playlistType {
                case .official: nil
                case .video: try queryManager.getMusicStartTimeList(id: id)
            }
            async let totalInfo = switch metaPlaylistInfo.playlistType {
                case .official: try queryManager.getTotalSongCount(id: id)
                case .video: try queryManager.getPlayLenght(id: id)
            }
            
            // rpc function 만들기
            let playlistDataDTO: YTPlaylistBodyDTO = try await YTPlaylistBodyDTO(
                originURL: metaPlaylistInfo.originURL,
                ytPlaylistType: metaPlaylistInfo.playlistType,
                totalInfo: totalInfo,
                musicInfos: musicInfoList,
                startTimes: startTimes
            )
            return playlistDataDTO
        }
    }
}
