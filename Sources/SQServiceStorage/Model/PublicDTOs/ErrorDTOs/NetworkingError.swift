//
//  File.swift
//  SQServiceStorage
//
//  Created by Greem on 2/17/25.
//

import Foundation

public enum NetworkingError: String, Error {
    case DataConvertFailed = "네트워크 요청과 일치하는 데이터 타입이 아님"
}
