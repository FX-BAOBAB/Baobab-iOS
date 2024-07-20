//
//  SignUpRepository.swift
//  Baobab
//
//  Created by 이정훈 on 7/9/24.
//

import Combine

protocol SignUpRepository {
    func requestSignUp(param: [String: Any]) -> AnyPublisher<SignUpResponse, any Error>
    func requestEmailDuplicationCheck(param: [String: Any]) -> AnyPublisher<Bool, any Error>
}
