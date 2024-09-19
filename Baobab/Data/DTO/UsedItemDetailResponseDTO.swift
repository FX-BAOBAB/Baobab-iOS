//
//  UsedItemDetailResponseDTO.swift
//  Baobab
//
//  Created by 이정훈 on 9/4/24.
//

import Foundation

// MARK: - UsedItemDetailResponseDTO
struct UsedItemDetailResponseDTO: Decodable {
    let result: TaskResult
    let body: UsedItemDetailResponseBody
}

// MARK: - Body
struct UsedItemDetailResponseBody: Decodable {
    let title: String
    let price: Int
    let description, postedAt: String
    let goods: Goods
}
