//
//  UserInfoResponseDTO.swift
//  Baobab
//
//  Created by 이정훈 on 7/22/24.
//

import Foundation

// MARK: - UserInfoResponseDTO
struct UserInfoResponseDTO: Decodable {
    let result: TaskResult
    let body: UserInfoResponseBody
}

// MARK: - Body
struct UserInfoResponseBody: Decodable {
    let id: Int
    let name, email, role: String
}
