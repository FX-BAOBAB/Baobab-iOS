//
//  ShippingProcessStatusResponseDTO.swift
//  Baobab
//
//  Created by 이정훈 on 8/20/24.
//

import Foundation

// MARK: - ShippingProcessStatusResponseDTO
struct ShippingProcessStatusResponseDTO: Decodable {
    let result: TaskResult
    let body: ShippingProcessStatusResponseBody
}

// MARK: - Body
struct ShippingProcessStatusResponseBody: Decodable {
    let shippingID, total: Int
    let status: String
    let current: Int
    let description: String

    enum CodingKeys: String, CodingKey {
        case shippingID = "shippingId"
        case total, status, current, description
    }
}
