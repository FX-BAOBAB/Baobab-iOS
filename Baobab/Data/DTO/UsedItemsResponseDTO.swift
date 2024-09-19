//
//  UsedItemsResponseDTO.swift
//  Baobab
//
//  Created by 이정훈 on 9/5/24.
//

import Foundation

// MARK: - UsedItemsResponseDTO
struct UsedItemsResponseDTO: Decodable {
    let result: TaskResult
    let body: [UsedItemsResponseBody]?
}

// MARK: - Body
struct UsedItemsResponseBody: Decodable {
    let usedGoodsID: Int
    let title: String
    let price: Int
    let postedAt, status: String
    let goods: Goods

    enum CodingKeys: String, CodingKey {
        case usedGoodsID = "usedGoodsId"
        case title, price, postedAt, status, goods
    }
}
