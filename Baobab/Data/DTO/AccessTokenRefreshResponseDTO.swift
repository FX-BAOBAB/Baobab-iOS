//
//  AccessTokenRefreshResponseDTO.swift
//  Baobab
//
//  Created by 이정훈 on 7/12/24.
//

import Foundation

// MARK: - AccessTokenRefreshResponseDTO
struct AccessTokenRefreshResponseDTO: Decodable {
    let result: TaskResult
    let body: AccessTokenRefreshResponseBody
}

// MARK: - AccessTokenRefreshResponseBody
struct AccessTokenRefreshResponseBody: Decodable {
    let token, expiredAt: String
}
