// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation
import Supabase

extension YTPlaylistBodyDTO {
    var isSameStartTimeAndMusicInfo: Bool {
        startTimes?.count == musicInfos.count 
    }
}

public final class PlaylistCachier {
    var supabaseURL:URL!
    var supabaseKey:String!
    var client:SupabaseClient?
    var queryManager: QueryManager!
    public init(supabaseURL: URL, anonKey: String) {
        setSupabaseClient(url: supabaseURL, anonKey: anonKey)
    }
    
    public func setSupabaseClient(url: URL, anonKey: String) {
        self.supabaseURL = url
        self.supabaseKey = anonKey
        self.client = SupabaseClient(supabaseURL: supabaseURL, supabaseKey: supabaseKey)
        self.queryManager = QueryManager(client: client)
    }
    
    
}





