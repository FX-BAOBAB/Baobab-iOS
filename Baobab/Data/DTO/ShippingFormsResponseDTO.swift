//
//  ShippingFormsResponseDTO.swift
//  Baobab
//
//  Created by 이정훈 on 8/1/24.
//

import Foundation

// MARK: - ShippingFormsResponseDTO
struct ShippingFormsResponseDTO: Decodable {
    let result: TaskResult
    let body: ShippingFormsResponseBody
}

// MARK: - Body
struct ShippingFormsResponseBody: Decodable {
    let shipping: [Shipping]
}

// MARK: - ShippingList
struct Shipping: Decodable {
    let shippingID: Int
    let deliveryDate, deliveryAddress, status: String
    let deliveryMan: Int?
    let goods: [Goods]

    enum CodingKeys: String, CodingKey {
        case shippingID = "shippingId"
        case deliveryDate, deliveryAddress, status, deliveryMan, goods
    }
}
