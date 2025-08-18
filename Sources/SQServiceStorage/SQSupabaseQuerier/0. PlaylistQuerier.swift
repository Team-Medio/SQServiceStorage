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
