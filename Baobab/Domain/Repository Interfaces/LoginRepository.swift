//
//  LoginRepository.swift
//  Baobab
//
//  Created by 이정훈 on 7/10/24.
//

import Combine

protocol LoginRepository {
    func login(params: [String: Any]) -> AnyPublisher<LoginResponse, any Error>
}
