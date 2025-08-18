//
//  File.swift
//  SQServiceStorage
//
//  Created by Greem on 2/17/25.
//

import Foundation
enum Period:String { case week, month, year }
enum PlaylistIDsRequest {
    case recent(limitcount:Int), most(period:Period,date:Date,limitcount:Int)
    case sendPlaylistLog(id:String, date:Date, locale: String)
    var httpMethod: String {
        switch self {
        case .most, .recent: "GET"
        case .sendPlaylistLog: "POST"
        }
    }
    var endPoint: String{
        switch self{
        case .most, .recent, .sendPlaylistLog:
            return "/functions/v1/PlaylistIDs"
        }
    }
    var queryItems: [URLQueryItem] {
        switch self{
        case .most(let period, let date,let limitcount): return [
            URLQueryItem(name: "filter", value: "most"),
            URLQueryItem(name: "period", value: period.rawValue),
            URLQueryItem(name: "date", value: date.convertToString()),
            URLQueryItem(name: "limitcount", value: "\(limitcount)"),
        ]
        case .recent(let limitcount): return [
                URLQueryItem(name: "filter", value: "recent"),
                URLQueryItem(name: "limitcount", value: "\(limitcount)")
            ]
        default: return []
        }
    }
    var httpBody: Data? {
        switch self {
        case .most, .recent: return nil
        case .sendPlaylistLog(id: let id, date: let date, locale: let locale):
            return try? JSONEncoder().encode(
                SendPlaylistLogModel(id: id, date: date.convertToString(), locale: locale)
            )
        }
    }
    func getURLRequest(baseUrl:URL, supabaseKey: String) -> URLRequest {
        let urlString = "\(baseUrl.absoluteString)\(self.endPoint)"
        var components = URLComponents(string: urlString)
        components?.queryItems = self.queryItems
        var request = URLRequest(url: components!.url!)
        request.httpMethod = self.httpMethod
        request.httpBody = self.httpBody
        request.addValue(supabaseKey, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
}

extension Date {
    func convertToString()->String {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withTimeZone]
        return dateFormatter.string(from: self)
    }
}

fileprivate struct SendPlaylistLogModel : Codable {
    let id: String
    let date: String
    let locale: String
}
