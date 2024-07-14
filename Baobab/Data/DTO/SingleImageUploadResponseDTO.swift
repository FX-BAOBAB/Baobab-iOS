//
//  ImageUploadResponseDTO.swift
//  Baobab
//
//  Created by 이정훈 on 7/13/24.
//

import Foundation

// MARK: - ImageUploadResponseDTO
struct SingleImageUploadResponseDTO: Decodable {
    let result: TaskResult
    let body: SingleImageUploadResponseBody
}

// MARK: - Body
struct SingleImageUploadResponseBody: Decodable {
    let id: Int
    let serverName, originalName, imageURL, caption: String
    let kind: String
    let goodsID: Int
    let bodyExtension: String

    enum CodingKeys: String, CodingKey {
        case id, serverName, originalName
        case imageURL = "imageUrl"
        case caption, kind
        case goodsID = "goodsId"
        case bodyExtension = "extension"
    }
}
