//
//  UpdateResponseDTO.swift
//  Baobab
//
//  Created by 이정훈 on 8/24/24.
//

import Foundation

struct UpdateResponseDTO: Decodable {
    let result: TaskResult
    let body: UpdateResponseBody
}

// MARK: - Body
struct UpdateResponseBody: Decodable {
    let message: String
}
