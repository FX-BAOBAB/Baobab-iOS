//
//  ItemStatusConversionResponseDTO.swift
//  Baobab
//
//  Created by 이정훈 on 8/23/24.
//

import Foundation

struct ItemStatusConversionResponseDTO: Decodable {
    let result: TaskResult
    let body: ItemStatusConversionResponseBody
}

// MARK: - Body
struct ItemStatusConversionResponseBody: Decodable {
    let message: String
}

