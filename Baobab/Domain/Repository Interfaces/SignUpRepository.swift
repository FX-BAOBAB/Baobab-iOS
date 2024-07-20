//
//  SignUpRepository.swift
//  Baobab
//
//  Created by 이정훈 on 7/9/24.
//

import Combine

protocol SignUpRepository {
    func requestSignUp(params: [String: Any]) -> AnyPublisher<SignUpResponse, any Error>
    func requestEmailDuplicationCheck(params: [String: Any]) -> AnyPublisher<Bool, any Error>
    func requestNickNameDuplicationCheck(params: [String: Any]) -> AnyPublisher<Bool, any Error>
}
