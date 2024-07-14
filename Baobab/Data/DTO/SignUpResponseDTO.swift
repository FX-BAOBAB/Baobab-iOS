//
//  SignUpResponseDTO.swift
//  Baobab
//
//  Created by 이정훈 on 7/9/24.
//

import Foundation

// MARK: - SignUpResponseDTO
struct SignUpResponseDTO: Decodable {
    let result: TaskResult
    let body: SignUpResponseBody?
}

// MARK: - SignUpResponseBody
struct SignUpResponseBody: Decodable {
    let message: String
}
