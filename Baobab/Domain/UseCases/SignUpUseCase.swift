//
//  SignUpUseCase.swift
//  Baobab
//
//  Created by 이정훈 on 7/1/24.
//

import MapKit
import Combine

//MARK: - SignUpUseCase Protocol
protocol SignUpUseCase {
    ///회원가입 요청 함수
    func execute(data: [String: Any]) -> AnyPublisher<SignUpResponse, any Error>
}

//MARK: - SignUpUseCaseImpl
final class SignUpUseCaseImpl: SignUpUseCase {
    private let repository: SignUpRepository
    
    init(repository: SignUpRepository) {
        self.repository = repository
    }
    
    func execute(data: [String: Any]) -> AnyPublisher<SignUpResponse, any Error> {
        return repository.requestSignUp(params: data)
    }
}
