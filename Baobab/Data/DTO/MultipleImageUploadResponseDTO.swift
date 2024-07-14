//
//  MultipleImageUploadResponseDTO.swift
//  Baobab
//
//  Created by 이정훈 on 7/14/24.
//

import Foundation

// MARK: - MultipleImageUploadResponseDTO
struct MultipleImageUploadResponseDTO: Codable {
    let result: MultipleImageUploadResult
    let body: [MultipleImageUploadResponseBody]
}

// MARK: - Body
struct MultipleImageUploadResponseBody: Codable {
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

// MARK: - Result
struct MultipleImageUploadResult: Codable {
    let resultCode: Int
    let resultMessage, resultDescription: String
}
