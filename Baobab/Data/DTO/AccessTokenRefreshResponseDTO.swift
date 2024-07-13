//
//  AccessTokenRefreshResponseDTO.swift
//  Baobab
//
//  Created by 이정훈 on 7/12/24.
//

import Foundation

// MARK: - AccessTokenRefreshResponseDTO
struct AccessTokenRefreshResponseDTO: Codable {
    let result: AccessTokenRefreshResult
    let body: AccessTokenRefreshResponseBody
}

// MARK: - AccessTokenRefreshResponseBody
struct AccessTokenRefreshResponseBody: Codable {
    let token, expiredAt: String
}

// MARK: - AccessTokenRefreshResult
struct AccessTokenRefreshResult: Codable {
    let resultCode: Int
    let resultMessage, resultDescription: String
}
