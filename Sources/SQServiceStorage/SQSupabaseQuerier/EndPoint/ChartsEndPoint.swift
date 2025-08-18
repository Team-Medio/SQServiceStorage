//
//  File.swift
//  SQServiceStorage
//
//  Created by Greem on 8/18/25.
//

import Foundation

enum ChartsEndPoint {
    case get_recent_channels(limitCount: Int)
    case get_recent_playlists(limitCount: Int)
    case get_most_channels(period: Period, date: Date, limitcount: Int)
    case get_most_playlists(period: Period, date: Date, limitcount: Int)
    
    var endPoint: String {
        switch self {
        case .get_recent_channels, .get_most_channels: return "/functions/v1/charts/channels"
        case .get_recent_playlists, .get_most_playlists: return "/functions/v1/charts/playlists"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
            default: .get
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .get_recent_channels(limitCount: let limitCount):
            return [
                URLQueryItem(name: "filter", value: "recent"),
                URLQueryItem(name: "limitcount", value: "\(limitCount)")
            ]
        case .get_recent_playlists(limitCount: let limitCount):
            return [
                URLQueryItem(name: "filter", value: "recent"),
                URLQueryItem(name: "limitcount", value: "\(limitCount)")
            ]
        case .get_most_channels(period: let period, date: let date, limitcount: let limitcount):
            return [
                URLQueryItem(name: "filter", value: "most"),
                URLQueryItem(name: "period", value: period.rawValue),
                URLQueryItem(name: "date", value: date.convertToString()),
                URLQueryItem(name: "limitcount", value: "\(limitcount)")
            ]
        case .get_most_playlists(period: let period, date: let date, limitcount: let limitcount):
            return [
                URLQueryItem(name: "filter", value: "most"),
                URLQueryItem(name: "period", value: period.rawValue),
                URLQueryItem(name: "date", value: date.convertToString()),
                URLQueryItem(name: "limitcount", value: "\(limitcount)")
            ]
        }
    }
    var httpBody: Data? { return nil }
    
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
