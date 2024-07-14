//
//  TaskResult.swift
//  Baobab
//
//  Created by 이정훈 on 7/14/24.
//

import Foundation

struct TaskResult: Decodable {
    let resultCode: Int
    let resultMessage, resultDescription: String
}
