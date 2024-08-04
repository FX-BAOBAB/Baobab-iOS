//
//  Date+ISO8601.swift
//  Baobab
//
//  Created by 이정훈 on 7/16/24.
//

import Foundation

extension Date {
    func toISOFormat() -> String {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        let isoString = isoFormatter.string(from: self)
        let startIndex = isoString.startIndex
        let lastIndex = isoString.index(startIndex, offsetBy: 22)
        
        return String(isoString[startIndex...lastIndex]) + "Z"
    }
    
    static func toSimpleFormat(from isoString: String, format: DateFormat) -> String {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        guard let date = isoFormatter.date(from: isoString) else {
            return ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        dateFormatter.dateFormat = format.rawValue
        
        return String(dateFormatter.string(from: date))
    }
    
    enum DateFormat: String {
        case full = "yyyy년 MM월 dd일 HH:mm"
        case withoutTime = "yyyy년 MM월 dd일"
        case simple = "MM/dd HH:mm"
    }
}
