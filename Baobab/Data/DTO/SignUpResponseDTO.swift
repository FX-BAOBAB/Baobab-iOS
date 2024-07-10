//
//  SignUpResponseDTO.swift
//  Baobab
//
//  Created by 이정훈 on 7/9/24.
//

import Foundation

// MARK: - SignUpResponseDTO
struct SignUpResponseDTO: Decodable {
    let result: SignUpResult
    let body: SignUpResponseBody?
}

// MARK: - SignUpResponseBody
struct SignUpResponseBody: Decodable {
    let message: String
}

// MARK: - SignUpResultResult
struct SignUpResult: Decodable {
    let resultCode: Int
    let resultMessage, resultDescription: String
}
