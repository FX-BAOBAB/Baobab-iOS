//
//  ChatRoomResponseDTO.swift
//  Baobab
//
//  Created by 이정훈 on 10/10/24.
//

import Foundation

// MARK: - ChatRoomResponseDTO
struct ChatRoomResponseDTO: Decodable {
    let result: TaskResult
    let body: [ChatRoomResponseBody]
}

// MARK: - Body
struct ChatRoomResponseBody: Decodable {
    let chatRoomID, usedGoodsID: Int
    let status, createdAt: String

    enum CodingKeys: String, CodingKey {
        case chatRoomID = "chatRoomId"
        case usedGoodsID = "usedGoodsId"
        case status, createdAt
    }
}
