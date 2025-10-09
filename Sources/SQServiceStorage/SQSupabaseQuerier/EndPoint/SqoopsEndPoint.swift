//
//  File.swift
//  SQServiceStorage
//
//  Created by Greem on 8/18/25.
//

import Foundation


enum SqoopsEndPoint {
    case insert_log(SqoopsLogRequest)
    
    var endPoint: String {
        switch self {
        case .insert_log: return "/functions/v1/sqoops/log"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
            default: .post
        }
    }
    
    var queryItems: [URLQueryItem] {
        return []
    }
    var httpBody: Data? {
        switch self {
        case .insert_log(let request):
            return try? JSONEncoder().encode(request)
        }
    }
    
    func getURLRequest(baseUrl:URL, supabaseKey: String) -> URLRequest {
        let urlString = "\(baseUrl.absoluteString)\(self.endPoint)"
        var components = URLComponents(string: urlString)
        components?.queryItems = self.queryItems
        var request = URLRequest(url: components!.url!)
        request.httpMethod = self.httpMethod.rawValue
        request.httpBody = self.httpBody
        request.addValue("Bearer \(supabaseKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
}
