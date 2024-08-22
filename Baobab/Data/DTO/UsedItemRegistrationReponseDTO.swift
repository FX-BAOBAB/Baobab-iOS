//
//  RegisterUsedItem.swift
//  Baobab
//
//  Created by 이정훈 on 8/21/24.
//

import Foundation

// MARK: - RegisterAsUsedItemReponseDTO
struct UsedItemRegistrationReponseDTO: Decodable {
    let result: TaskResult
    let body: RegisterAsUsedItemReponseBody
}

// MARK: - Body
struct RegisterAsUsedItemReponseBody: Decodable {
    let message: String
}
