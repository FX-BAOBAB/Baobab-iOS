//
//  ReceivingResponseDTO.swift
//  Baobab
//
//  Created by 이정훈 on 7/15/24.
//

import Foundation

// MARK: - ReceivingResponseDTO
struct ReceivingResponseDTO: Decodable {
    let result: TaskResult
    let body: Body
}

// MARK: - Body
struct Body: Decodable {
    let id: Int
    let visitAddress, visitDate, guaranteeAt, receivingStatus: String
    let goods: [Goods]
    let takeBackResponse: TakeBackResponse?
}

// MARK: - Goods
struct Goods: Decodable {
    let id: Int
    let name, category: String
    let quantity: Int
    let basicImages, faultImages: [ImageMetaData]
}

// MARK: - GoodsImage
struct ImageMetaData: Decodable {
    let id: Int
    let serverName, originalName, imageURL, caption: String
    let kind: String
    let goodsID: Int

    enum CodingKeys: String, CodingKey {
        case id, serverName, originalName
        case imageURL = "imageUrl"
        case caption, kind
        case goodsID = "goodsId"
    }
}

// MARK: - TakeBackResponse
struct TakeBackResponse: Decodable {
    let id: Int
    let status, takeBackRequestAt: String
    let goods: [Goods]
}
