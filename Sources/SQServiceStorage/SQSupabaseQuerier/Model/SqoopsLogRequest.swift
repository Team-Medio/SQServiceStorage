//
//  SqoopsLogReqeust.swift
//  SQServiceStorage
//
//  Created by Greem on 8/18/25.
//

import Foundation

struct SqoopsLogRequest: Encodable {
    let id: String
    let date: Date
    let locale: String
    let channelID: String
}
