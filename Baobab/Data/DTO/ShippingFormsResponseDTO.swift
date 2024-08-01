//
//  ShippingFormsResponseDTO.swift
//  Baobab
//
//  Created by 이정훈 on 8/1/24.
//

import Foundation

// MARK: - ShippingFormResponseDTO
struct ShippingFormsResponseDTO: Decodable {
    let result: TaskResult
    let body: ShippingFormsResponseBody
}

// MARK: - Body
struct ShippingFormsResponseBody: Decodable {
    let shippingList: [ShippingData]
}

// MARK: - ShippingElement
struct ShippingData: Decodable {
    let shippingID: Int
    let deliveryDate, deliveryAddress, status: String
    let deliveryManID: Int
    let goods: [Goods]
    
    enum CodingKeys: String, CodingKey {
        case shippingID = "shippingId"
        case deliveryManID = "deliveryMan"
        case deliveryDate, deliveryAddress, status, goods
    }
}
