//
//  RequestError.swift
//  Baobab
//
//  Created by 이정훈 on 7/12/24.
//

import Foundation

enum RequestError: Error {
    case expiredToken(Int)
    case noTokenValue
}
