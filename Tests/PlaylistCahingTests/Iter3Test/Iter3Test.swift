import XCTest
@testable import SQServiceStorage
//@testable import PlaylistQuerier
let ANONKEY:String = ""

let SUPAURL: String = ""
final class Iter3Test: XCTestCase {

    
    func testExample() async throws {
        // XCTest Documentation
        // https://developer.apple.com/documentation/xctest
        // Defining Test Cases and Test Methods
        // https://developer.apple.com/documentation/xctest/defining_test_cases_and_test_methods
        
//        let cachier = PlaylistQuerier(supabaseURL: URL(string: SUPAURL)!, anonKey: ANONKEY)
//        let ids = try await cachier.getPlaylistIDsByAccessDateDESC(limit: 5)
//        print(ids)
    }
    
//    func testUploadMusiclistTable() async throws{
//        let playlistCaching = await PlaylistCachier(supabaseURL: URL(string:projectURLString)!, anonKey: anonKey)
//        let musicKeyTables = (8...12).map{ MusicKeyTable(platformKey: "apple\($0)", ISRC: "\($0)-1") }
//        let originalMusiclistTable = OriginalMusicListTable(originalURLString: "https://www.duam.com",
//                                                            platformTable: .apple,
//                                                            musicKeyList: musicKeyTables,
//                                                            lastDate: Date(),
//                                                            title: "안녕하세요",
//                                                            thumbnailURLString: "wow")
//        
//        
//        try await playlistCaching.createOriginalPlaylist(originalMusicList: originalMusiclistTable)
//    }
//    func testGetMusiclistTable() async throws{
//        let playlistCaching = await PlaylistCachier(supabaseURL: URL(string:projectURLString)!, anonKey: anonKey)
//        let res: OriginalMusicListTable = try await playlistCaching.getOriginalPlaylist(urlString: "https://www.duam.com")
//        print("--------MusicListTable---------")
//        dump(res)
//    }
}
