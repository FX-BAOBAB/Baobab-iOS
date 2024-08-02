//
//  ReturnFormsResponseDTO.swift
//  Baobab
//
//  Created by 이정훈 on 8/1/24.
//

import Foundation

// MARK: - ReturnFormsResponseDTO
struct ReturnFormsResponseDTO: Decodable {
    let result: TaskResult
    let body: ReturnFormsResponseBody
}

// MARK: - Body
struct ReturnFormsResponseBody: Decodable {
    let takeBackResponseList: [TakeBackResponse]
}
