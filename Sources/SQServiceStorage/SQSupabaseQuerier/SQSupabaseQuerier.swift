//
//  SQSupabaseQuerier.swift
//  SQServiceStorage
//
//  Created by Greem on 8/18/25.
//

import Foundation
import Supabase

public class SQSupabaseQuerier {
    var supabaseURL:URL!
    var supabaseKey:String!
    var client: SupabaseClient?
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
}
