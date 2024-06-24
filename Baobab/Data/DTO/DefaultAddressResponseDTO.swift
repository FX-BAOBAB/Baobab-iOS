//
//  DefaultAddressResponseDTO.swift
//  Baobab
//
//  Created by 이정훈 on 5/29/24.
//

import Foundation

// MARK: - DefaultAddressDTO
struct DefaultAddressResponseDTO: Codable {
    let result: DefaultAddressDTOResult
    let body: DefaultAddressDTOBody
}

// MARK: - DefaultAddressDTOBody
struct DefaultAddressDTOBody: Codable {
    let address: AddressDetail
}

// MARK: - AddressData
struct AddressDetail: Codable {
    let id: Int
    let address, detailAddress: String
    let post: Int
    let basicAddress: Bool

    enum CodingKeys: String, CodingKey {
        case id, address
        case detailAddress = "detail_address"
        case post
        case basicAddress = "basic_address"
    }
}

// MARK: - DefaultAddressDTOResult
struct DefaultAddressDTOResult: Codable {
    let resultCode: Int
    let resultMessage, resultDescription: String

    enum CodingKeys: String, CodingKey {
        case resultCode = "result_code"
        case resultMessage = "result_message"
        case resultDescription = "result_description"
    }
}
