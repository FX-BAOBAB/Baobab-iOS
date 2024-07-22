//
//  LoginResponseDTO.swift
//  Baobab
//
//  Created by 이정훈 on 7/10/24.
//

import Foundation

// MARK: - LoginResponseDTO
struct LoginResponseDTO: Decodable {
    let result: TaskResult
    let body: LoginResponseBody?
}

// MARK: - LoginResponseBody
struct LoginResponseBody: Decodable {
    let accessToken, accessTokenExpiredAt, refreshToken, refreshTokenExpiredAt: String
}
