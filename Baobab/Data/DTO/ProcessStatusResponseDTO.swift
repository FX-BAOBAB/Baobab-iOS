//
//  ProcessStatusResponseDTO.swift
//  Baobab
//
//  Created by 이정훈 on 7/31/24.
//

import Foundation

import Foundation

// MARK: - ProcessStatusResponseDTO
struct ProcessStatusResponseDTO: Decodable {
    let result: TaskResult
    let body: ProcessStatusResponseBody
}

// MARK: - ProcessStatusResponseBody
struct ProcessStatusResponseBody: Decodable {
    let receivingID, total: Int
    let status: String
    let current: Int
    let description: String

    enum CodingKeys: String, CodingKey {
        case receivingID = "receivingId"
        case total, status, current, description
    }
}
