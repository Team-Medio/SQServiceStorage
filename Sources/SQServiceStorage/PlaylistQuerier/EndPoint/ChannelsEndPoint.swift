//
//  ChannelsEndPoint.swift
//  SQServiceStorage
//
//  Created by Greem on 8/18/25.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
}

enum ChannelsEndPoint {
    case playlists(channelID: String,limitCount:Int)
    var endPoint: String {
        switch self {
        case .playlists: "/functions/v1/channels/playlists"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .playlists: return .get
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .playlists(channelID: let channelID, limitCount: let limitCount):
            return [
                URLQueryItem(name: "channelId", value: channelID),
                URLQueryItem(name: "limitcount", value: "\(limitCount)")
            ]
        }
    }
    var httpBody: Data? {
        switch self {
        case .playlists: return nil
        }
    }
    
    func getURLRequest(baseUrl:URL, supabaseKey: String) -> URLRequest {
        let urlString = "\(baseUrl.absoluteString)\(self.endPoint)"
        var components = URLComponents(string: urlString)
        components?.queryItems = self.queryItems
        var request = URLRequest(url: components!.url!)
        request.httpMethod = self.httpMethod.rawValue
        request.httpBody = self.httpBody
        request.addValue(supabaseKey, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
}
