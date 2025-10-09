//
//  SqoopsLogReqeust.swift
//  SQServiceStorage
//
//  Created by Greem on 8/18/25.
//

import Foundation

struct SqoopsLogRequest: Encodable {
    let id: String
    let date: String
    let locale: String
    let channelID: String
    
    init(
        id: String,
        date: Date,
        locale: String,
        channelID: String
    ) {
        self.id = id
        self.date = date.ISO8601Format(.iso8601(timeZone: .autoupdatingCurrent, includingFractionalSeconds: false))
        self.locale = locale
        self.channelID = channelID
    }
}


