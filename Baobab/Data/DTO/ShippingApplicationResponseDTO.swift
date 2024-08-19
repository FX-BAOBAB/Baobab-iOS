//
//  ShippingResponseDTO.swift
//  Baobab
//
//  Created by 이정훈 on 8/19/24.
//

import Foundation

// MARK: - ShippingResponseDTO
struct ShippingApplicationResponseDTO: Decodable {
    let result: TaskResult
    let body: ShippingResponseBody?
}

// MARK: - ShippingResponseBody
struct ShippingResponseBody: Decodable {
    let message: String
}

