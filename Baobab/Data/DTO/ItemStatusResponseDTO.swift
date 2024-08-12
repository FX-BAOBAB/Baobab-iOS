//
//  ItemStatusResponseDTO.swift
//  Baobab
//
//  Created by 이정훈 on 7/25/24.
//

import Foundation

// MARK: - ItemStatusResponseDTO
struct ItemStatusResponseDTO: Decodable {
    let result: TaskResult
    let body: [Goods]?
}
