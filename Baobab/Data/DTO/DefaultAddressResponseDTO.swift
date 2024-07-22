//
//  DefaultAddressResponseDTO.swift
//  Baobab
//
//  Created by 이정훈 on 5/29/24.
//

import Foundation

// MARK: - DefaultAddressResponseDTO
struct DefaultAddressResponseDTO: Decodable {
    let result: TaskResult
    let body: DefaultAddressResponseBody
}

// MARK: - DefaultAddressResponseBody
struct DefaultAddressResponseBody: Decodable {
    let id: Int
    let address, detailAddress, post: String
    let basicAddress: Bool
}
