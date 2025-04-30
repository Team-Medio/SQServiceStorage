//
//  PlaylistCachierError.swift
//  SQServiceStorage
//
//  Created by Greem on 12/22/24.
//

import Foundation

public enum PlaylistCachierError: String, Error {
    
    case dateConvertFailed = "날짜 변환 실패"
    
    case clientKeyNotEntered = "클라이언트 키를 설정하지 않았습니다."
    
    case unknownCreateFailed = "알 수 없는 플레이리스트 생성 실패"
    case unknwonGetFailed = "알 수 없는 플레이리스트 가져오기 실패"
    
    case playlistNotExist = "플레이리스트 없음"
    case musicKeyloss = "플레이리스트 내부 음악 정보가 손실"
    
    case overOneMonth = "1개월 이상 플레이리스트 캐시 불가"
    case metaDataNotFound = "메타 데이터를 가져올 수 없음"
    case notMatchVideoStartTime = "플레이리스트 시작 시간 배열과 음악 배열 불일치"
}
