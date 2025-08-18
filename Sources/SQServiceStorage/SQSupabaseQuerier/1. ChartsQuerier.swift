//
//  File.swift
//  SQServiceStorage
//
//  Created by Greem on 8/18/25.
//

import Foundation

public struct ChartsQuerier {
    private let supabaseURL:URL
    private let supabaseKey:String
    
    public init(supabaseURL: URL, supabaseKey: String) {
        self.supabaseURL = supabaseURL
        self.supabaseKey = supabaseKey
    }
    
    public func getRecentChannels(limitCount: Int) async throws -> ChartRecentChannelsResponse {
        let endPoint = ChartsEndPoint.get_recent_channels(limitCount: limitCount)
        let request = endPoint.getURLRequest(baseUrl: self.supabaseURL, supabaseKey: self.supabaseKey)
        guard let (data, _ ) = try? await URLSession.shared.data(for: request),
              let recentChannelsResponse = try? data.convertToTable(type: ChartRecentChannelsResponse.self) else {
            throw NetworkingError.DataConvertFailed
        }
        return recentChannelsResponse
    }
    
    public func getMostChannels(period: Period, date: Date, limitCount: Int) async throws -> ChartMostChannelsResponse {
        let endPoint = ChartsEndPoint.get_most_channels(period: period, date: date, limitcount: limitCount)
        let request = endPoint.getURLRequest(baseUrl: self.supabaseURL, supabaseKey: supabaseKey)
        guard let (data, _ ) = try? await URLSession.shared.data(for: request),
              let mostChannelsResponse = try? data.convertToTable(type: ChartMostChannelsResponse.self) else {
            throw NetworkingError.DataConvertFailed
        }
        return mostChannelsResponse
    }
    
    public func getRecentPlaylists(limitCount: Int) async throws -> ChartPlaylistsResponse {
        let endPoint = ChartsEndPoint.get_recent_playlists(limitCount: limitCount)
        let request = endPoint.getURLRequest(baseUrl: supabaseURL, supabaseKey: supabaseKey)
        guard let (data, _ ) = try? await URLSession.shared.data(for: request),
              let recentPlaylistsResponse = try? data.convertToTable(type: ChartPlaylistsResponse.self) else {
            throw NetworkingError.DataConvertFailed
        }
        return recentPlaylistsResponse
    }
    
    public func getMostPlaylists(period: Period, date: Date, limitCount: Int)  async throws -> ChartPlaylistsResponse {
        let endPoint = ChartsEndPoint.get_most_playlists(period: period, date: date, limitcount: limitCount)
        let request = endPoint.getURLRequest(baseUrl: supabaseURL, supabaseKey: supabaseKey)
        guard let (data, _ ) = try? await URLSession.shared.data(for: request),
              let mostPlaylistsResponse = try? data.convertToTable(type: ChartPlaylistsResponse.self) else {
            throw NetworkingError.DataConvertFailed
        }
        return mostPlaylistsResponse
    }
}
