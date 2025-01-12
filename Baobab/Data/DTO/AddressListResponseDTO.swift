//
//  AddressListResponseDTO.swift
//  Baobab
//
//  Created by 이정훈 on 7/13/24.
//

import Foundation

// MARK: - AddressListResponseDTO
struct AddressListResponseDTO: Decodable {
    let result: TaskResult
    let body: AddressListResponseBody
}

// MARK: - AddressListResponseBody
struct AddressListResponseBody: Decodable {
    let addressDtoList: [AddressDtoList]
}

// MARK: - AddressDtoList
struct AddressDtoList: Decodable {
    let id: Int
    let address, detailAddress, post: String
    let basicAddress: Bool
}
