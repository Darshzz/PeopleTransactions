//
//  DateConversion.swift
//  PeopleTransactions
//
//  Created by Darsh on 15/07/22.
//

import Foundation

extension String {
    
    var yyyyMMddTimeZone: Date? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter.date(from: self)
    }
    
    var mmddyyyy: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.string(from: self.yyyyMMddTimeZone ?? Date())
    }
}
