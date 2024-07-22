//
//  CategoryData.swift
//  Baobab
//
//  Created by 이정훈 on 5/13/24.
//

import Foundation

let categories: [String] = [
    "소형 가구 [ 5000원 / 1ea / 월 ]",
    "대형 가구 [ 15000원 / 1ea / 월 ]",
    "소형 가전 [ 5000원 / 1ea / 월 ]",
    "대형 가전 [ 15000원 / 1ea / 월 ]",
    "여름 옷 [ 4000원 / 10벌 / 월 ]",
    "가방 [ 8000원 / 10개 / 월 ]",
    "신발 [ 8000원 / 10개 / 월 ]",
    "니트 [ 4000원 / 10벌 / 월 ]",
    "패딩 [ 10000원 / 3벌 / 월 ]",
    "코트 [ 10000원 / 4벌 / 월 ]",
    "원피스 [ 10000원 / 6벌 / 월 ]",
    "책 [ 5000원 / 10ea / 월 ]"
]

let engCategroy = [
    "소형 가구": "SMALL_FURNITURE",
    "대형 가구": "LARGE_FURNITURE",
    "소형 가전": "SMALL_APPLIANCES",
    "대형 가전": "LARGE_APPLIANCES",
    "여름 옷": "SHORT_SLEEVE",
    "가방": "BAG",
    "신발": "SHOES",
    "니트": "KNIT",
    "패딩": "PADDING",
    "코트": "COAT",
    "원피스": "ONE_PIECE",
    "책": "BOOKS"
]

extension String {
    func toEngCategory() -> String {
        guard let engName = engCategroy[self] else {
            return ""
        }
        
        return engName
    }
}
