//
//  ReceivingFormsResponseDTO.swift
//  Baobab
//
//  Created by 이정훈 on 7/26/24.
//

import Foundation

// MARK: - FormsResponseDTO
struct ReceivingFormsResponseDTO: Decodable {
    let result: TaskResult
    let body: FormsResponseBody
}

// MARK: - FormsResponseBody
struct FormsResponseBody: Decodable {
    let receivingResponseList: [ReceivingResponseBody]
}
