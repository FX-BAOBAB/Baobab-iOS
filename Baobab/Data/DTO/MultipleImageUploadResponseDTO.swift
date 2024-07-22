//
//  MultipleImageUploadResponseDTO.swift
//  Baobab
//
//  Created by 이정훈 on 7/14/24.
//

import Foundation

// MARK: - MultipleImageUploadResponseDTO
struct MultipleImageUploadResponseDTO: Decodable {
    let result: TaskResult
    let body: [MultipleImageUploadResponseBody]
}

// MARK: - Body
struct MultipleImageUploadResponseBody: Codable {
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
