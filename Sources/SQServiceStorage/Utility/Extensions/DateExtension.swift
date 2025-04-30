//
//  DateExtension.swift
//  PlaylistCachier
//
//  Created by Greem on 11/13/24.
//

import Foundation

extension Date {
    var isOverOneMonthAgo: Bool {
        let oneMonthAgo = Calendar.current.date(byAdding: .month, value: -1, to: Date())!
        return self <= oneMonthAgo
    }
}
