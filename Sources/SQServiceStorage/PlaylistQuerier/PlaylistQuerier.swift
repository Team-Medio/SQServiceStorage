//
//  File.swift
//  PlaylistCachier
//
//  Created by Greem on 11/21/24.
//

import Foundation
import Supabase


public final class PlaylistQuerier {
    var supabaseURL:URL!
    var supabaseKey:String!
    var client:SupabaseClient?
    var queryManager: QueryManager!
    public init(supabaseURL: URL, supabaseKey: String) {
        setSupabaseClient(url: supabaseURL, anonKey: supabaseKey)
    }
    public func setSupabaseClient(url: URL, anonKey: String) {
        self.supabaseURL = url
        self.supabaseKey = anonKey
        self.client = SupabaseClient(supabaseURL: supabaseURL, supabaseKey: supabaseKey)
        self.queryManager = QueryManager(client: client)
    }
    
    
    public func getIDsByAccessDateDESC(limit: Int = 10) async throws -> [YTPlaylistHeadDTO.ID] {
        let recentAccessDate = PlaylistIDsRequest
            .recent(limitcount: limit)
            .getURLRequest(baseUrl: supabaseURL, supabaseKey: supabaseKey)
        guard let (data, _) = try? await URLSession.shared.data(for: recentAccessDate),
          let ids = try? data.convertToTable(type: [String].self) else {
            throw NetworkingError.DataConvertFailed
        }
        return ids
    }
    
    public func getIDsByWeeklyMostCountsDESC(date:Date,limit: Int = 10) async throws -> [YTPlaylistHeadDTO.ID] {
        let mostWeeklyRequest = PlaylistIDsRequest
            .most(period: .week, date: date, limitcount: limit)
            .getURLRequest(baseUrl: self.supabaseURL, supabaseKey: self.supabaseKey)
        guard let (data, _ ) = try? await URLSession.shared.data(for: mostWeeklyRequest),
              let ids = try? data.convertToTable(type: [String].self) else {
            throw NetworkingError.DataConvertFailed
        }
        return ids
    }
    
    public func appendPlaylistLog(playlistID: String,
                                  date: Date = Date(),
                                  locale: String = Locale.current.identifier) async throws {
        let appendLogRequest = PlaylistIDsRequest
            .sendPlaylistLog(id: playlistID, date: date, locale: locale)
            .getURLRequest(baseUrl: self.supabaseURL, supabaseKey: self.supabaseKey)
        guard let (_ , response) = try? await URLSession.shared.data(for: appendLogRequest),
            (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw NetworkingError.DataConvertFailed
        }
    }

    
    public func getPlaylistHead(id: String) async throws -> YTPlaylistHeadDTO {
        let table = try await queryManager.getPlaylistHeadTable(id: id)
        let channelTable = try await queryManager.getYTChannelInfoTable(id: table.channelID)
        return YTPlaylistHeadDTO(headTable: table, channelTable: channelTable)
    }
    
    /// 한번에 여러 플레이리스트 메타데이터를 가져옵니다.
    public func getPlaylistHeads(ids:[String]) async throws -> [YTPlaylistHeadDTO] {
        guard let client = client else { throw PlaylistCachierError.clientKeyNotEntered }
        return try await client.rpc(
            RPCFunctionType.getHeads.rawValue,
            params: ["ids": ids] )
            .convertToTable(type: [YTPlaylistHeadWithChannelInfoTable].self)
            .map{ $0.convertToYTPlaylistHead }
    }
    
    public func getTotalSongsCount() async throws -> Int {
        guard let client = client else { throw PlaylistCachierError.clientKeyNotEntered }
        return try await client.rpc( RPCFunctionType.getTotalSongsCount.rawValue)
            .convertToTable(type: Int.self)
    }
    public func getTotalPlaylistsCount() async throws -> Int {
        guard let client = client else { throw PlaylistCachierError.clientKeyNotEntered }
        return try await client.rpc( RPCFunctionType.getTotalPlaylistsCount.rawValue)
            .convertToTable(type: Int.self)
    }
    public func getIsShazamed(id: String) async throws -> Bool {
        guard let client = client else { throw PlaylistCachierError.clientKeyNotEntered }
        return try await client.rpc(
            RPCFunctionType.getIsShazamed.rawValue,
            params: ["playlistid": id]
        ).convertToTable(type: Bool.self)
    }
}
