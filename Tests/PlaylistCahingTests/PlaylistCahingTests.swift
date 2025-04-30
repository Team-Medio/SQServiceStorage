import XCTest
@testable import SQServiceStorage
final class PlaylistCahingTests: XCTestCase {
    let anonKey:String = ""
    
    let projectURLString: String = ""
    
    func testExample() async throws {
        // XCTest Documentation
        // https://developer.apple.com/documentation/xctest
        // Defining Test Cases and Test Methods
        // https://developer.apple.com/documentation/xctest/defining_test_cases_and_test_methods
        
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
