//
//  PurchaseUsedItemResponseDTO.swift
//  Baobab
//
//  Created by 이정훈 on 9/7/24.
//

import Foundation

// MARK: - PurchaseUsedItemsResponseDTO
struct PurchaseUsedItemsResponseDTO: Decodable {
    let result: TaskResult
    let body: PurchaseUsedItemsResponseBody
}

// MARK: - Body
struct PurchaseUsedItemsResponseBody: Decodable {
    let usedGoodsOrderID, buyerID, sellerID: Int
    let createdAt: String
    let usedGoodsID: Int

    enum CodingKeys: String, CodingKey {
        case usedGoodsOrderID = "usedGoodsOrderId"
        case buyerID = "buyerId"
        case sellerID = "sellerId"
        case createdAt
        case usedGoodsID = "usedGoodsId"
    }
}
