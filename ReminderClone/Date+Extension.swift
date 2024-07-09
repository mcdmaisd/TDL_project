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
        let koreanTimeZone = TimeZone(identifier: "Asia/Seoul")!

        dateFormatter.locale = NSLocale.current
        dateFormatter.timeZone = koreanTimeZone

        let formattedDate = dateFormatter.string(from: self)

        return formattedDate
    }
    
    var convertDateToInt: Int {
        let dateFormatter = DateFormatter()
        let dateFormat = "yyyyMMdd"
        dateFormatter.dateFormat = dateFormat
        let koreanTimeZone = TimeZone(identifier: "Asia/Seoul")!

        dateFormatter.locale = NSLocale.current
        dateFormatter.timeZone = koreanTimeZone

        let formattedDate = dateFormatter.string(from: self)

        return Int(formattedDate) ?? 0
    }
    
    func getToday() -> String {
        let today = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        dateFormatter.dateFormat = "yyyyMMdd"
        return dateFormatter.string(from: today)
    }
}
