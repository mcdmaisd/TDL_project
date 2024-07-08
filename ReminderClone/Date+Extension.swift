//
//  Date+Extension.swift
//  ReminderClone
//
//  Created by ilim on 2024-07-08.
//

import Foundation

extension Date {
    var convertedDate: String {
        let dateFormatter = DateFormatter()
        let dateFormat = "yyyy.MM.dd"
        dateFormatter.dateFormat = dateFormat

        dateFormatter.locale = NSLocale.current
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00")

        dateFormatter.dateFormat = dateFormat
        let formattedDate = dateFormatter.string(from: self)

        return formattedDate
    }
}
