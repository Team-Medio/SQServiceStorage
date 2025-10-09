//
//  Extractor.swift
//  PlaylistCachier
//
//  Created by Greem on 11/11/24.
//

import Foundation
import Supabase

extension Data {
    func convertToTable<T>(type: T.Type) throws -> T where T: Decodable {
        try JSONDecoder().decode(type, from: self)
    }
}

final class QueryManager {
    
    var client : SupabaseClient?
    
    init(client: SupabaseClient?) {
        self.client = client
    }
    
    func clientSafety<T>(action: (SupabaseClient) async throws -> T) async throws -> T {
        guard let client else{ throw PlaylistCachierError.clientKeyNotEntered }
        return try await action(client)
    }
}
