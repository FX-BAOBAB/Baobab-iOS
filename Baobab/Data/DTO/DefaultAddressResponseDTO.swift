//
//  DefaultAddressResponseDTO.swift
//  Baobab
//
//  Created by 이정훈 on 5/29/24.
//

import Foundation

// MARK: - DefaultAddressResponseDTO
struct DefaultAddressResponseDTO: Codable {
    let result: DefaultAddressResult
    let body: DefaultAddressResponseBody
}

// MARK: - DefaultAddressResponseBody
struct DefaultAddressResponseBody: Codable {
    let id: Int
    let address, detailAddress, post: String
    let basicAddress: Bool
}

// MARK: - DefaultAddressResult
struct DefaultAddressResult: Codable {
    let resultCode: Int
    let resultMessage, resultDescription: String
}
