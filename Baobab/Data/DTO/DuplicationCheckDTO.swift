//
//  DuplicationCheckDTO.swift
//  Baobab
//
//  Created by 이정훈 on 7/20/24.
//

import Foundation

// MARK: - EmailDuplicationCheckDTO
struct DuplicationCheckDTO: Codable {
    let result: EmailDuplicationCheckResult
    let body: EmailDuplicationCheckResponseBody
}

// MARK: - Body
struct EmailDuplicationCheckResponseBody: Codable {
    let duplication: Bool
}

// MARK: - Result
struct EmailDuplicationCheckResult: Codable {
    let resultCode: Int
    let resultMessage, resultDescription: String
}
