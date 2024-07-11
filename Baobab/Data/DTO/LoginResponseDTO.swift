//
//  LoginResponseDTO.swift
//  Baobab
//
//  Created by 이정훈 on 7/10/24.
//

import Foundation

// MARK: - LoginResponseDTO
struct LoginResponseDTO: Codable {
    let result: LoginResult
    let body: LoginResponseBody?
}

// MARK: - LoginResponseBody
struct LoginResponseBody: Codable {
    let accessToken, accessTokenExpiredAt, refreshToken, refreshTokenExpiredAt: String
}

// MARK: - LoginResult
struct LoginResult: Codable {
    let resultCode: Int
    let resultMessage, resultDescription: String
}
