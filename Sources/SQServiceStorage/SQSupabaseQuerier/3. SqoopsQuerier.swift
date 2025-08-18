//
//  SqoopsQuerier.swift
//  SQServiceStorage
//
//  Created by Greem on 8/18/25.
//

import Foundation

public struct SqoopsQurier {
    private let supabaseURL: URL
    private let supabaseKey: String
    
    public init(supabaseURL: URL, supabaseKey: String) {
        self.supabaseKey = supabaseKey
        self.supabaseURL = supabaseURL
    }
    
    public func appendPlaylistLog(
        playlistID: String,
        date: Date = Date(),
        locale: String = Locale.current.identifier,
        channelID: String
    ) async throws {
        let logRequestDTO = SqoopsLogReqeust(id: playlistID, date: date, locale: locale, channelID: channelID)
        let logURLRequest = SqoopsEndPoint.insert_log(logRequestDTO)
            .getURLRequest(baseUrl: self.supabaseURL, supabaseKey: self.supabaseKey)
        guard let (_ , response) = try? await URLSession.shared.data(for: logURLRequest),
              (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw NetworkingError.DataConvertFailed
        }
    }
}
