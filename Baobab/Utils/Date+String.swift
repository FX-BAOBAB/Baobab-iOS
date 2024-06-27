//
//  Date+String.swift
//  Baobab
//
//  Created by 이정훈 on 5/20/24.
//

import Foundation

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        return dateFormatter.string(from: self)
    }
}
