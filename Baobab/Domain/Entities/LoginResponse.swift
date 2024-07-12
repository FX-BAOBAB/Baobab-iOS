//
//  LoginResponse.swift
//  Baobab
//
//  Created by 이정훈 on 7/10/24.
//

import Foundation

struct LoginResponse {
    let result: Bool
    let accessToken: String?
    let refreshToken: String?
}
