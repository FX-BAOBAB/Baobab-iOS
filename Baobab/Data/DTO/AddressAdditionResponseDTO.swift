//
//  AddressAdditionResponseDTO.swift
//  Baobab
//
//  Created by 이정훈 on 8/28/24.
//

import Foundation

// MARK: - AddressAdditionResponseDTO
struct AddressAdditionResponseDTO: Decodable {
    let result: TaskResult
    let body: AddressAdditionResponseBody
}

// MARK: - Body
struct AddressAdditionResponseBody: Decodable {
    let id: Int
    let address, detailAddress, post: String
    let basicAddress: Bool
}
