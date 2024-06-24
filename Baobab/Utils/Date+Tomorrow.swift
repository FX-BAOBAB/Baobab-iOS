//
//  Date+Tomorrow.swift
//  Baobab
//
//  Created by 이정훈 on 5/20/24.
//

import Foundation

extension Date {
    static var tomorrow: Date {
        let calendar = Calendar.current    // gregorian calendar information
        let tomorrowDate = calendar.date(byAdding: .day, value: 1, to: Date())    //다음 날에 대한 Date 객체
        
        guard let tomorrowDate else {
            return Date()
        }
        
        //tomorrowDate의 DateComponents 객체(연도, 월, 일 등에 대한 정보를 가짐)
        let tomorrowComponent = Calendar.current.dateComponents([.year, .month, .day], from: tomorrowDate)
        
        if let year = tomorrowComponent.year, let month = tomorrowComponent.month, let day = tomorrowComponent.day {
            let tomorrow = DateComponents(year: year, month: month, day: day, hour: 7)    //해당 날짜와 시간이 10 a.m인 DateComponents 객체
            
            //DateComponents 객체로 Date 객체 생성
            if let tomorrow = Calendar.current.date(from: tomorrow) {
                return tomorrow
            } else {
                return Date()
            }
        } else {
            return Date()
        }
    }
}
