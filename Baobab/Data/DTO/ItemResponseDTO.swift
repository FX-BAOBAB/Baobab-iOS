//
//  ItemStatusResponseDTO.swift
//  Baobab
//
//  Created by 이정훈 on 7/25/24.
//

import Foundation

// MARK: - ItemStatusResponseDTO
struct ItemResponseDTO: Decodable {
    let result: TaskResult
    let body: [Goods]?
}
