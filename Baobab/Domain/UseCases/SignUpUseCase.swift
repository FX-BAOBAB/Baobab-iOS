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
    
    ///이메일 중복 확인을 요청하는 함수
    func checkEmailDuplication(params: [String: Any]) -> AnyPublisher<Bool, any Error>
    
    ///닉네임 중복 확인을 요청하는 함수
    func checkNickNameDuplication(params: [String: Any]) -> AnyPublisher<Bool, any Error>
}

//MARK: - SignUpUseCaseImpl
final class SignUpUseCaseImpl: SignUpUseCase {
    private let repository: SignUpRepository
    private let checkEmailDuplicationUseCase: CheckEmailDuplicationUseCase
    private let checkNickNameDuplicationUseCase: CheckNickNameDuplicationUseCase
    
    init(repository: SignUpRepository,
         checkEmailDuplicationUseCase: CheckEmailDuplicationUseCase,
         checkNickNameDuplicationUseCase: CheckNickNameDuplicationUseCase) {
        self.repository = repository
        self.checkEmailDuplicationUseCase = checkEmailDuplicationUseCase
        self.checkNickNameDuplicationUseCase = checkNickNameDuplicationUseCase
    }
    
    func execute(data: [String: Any]) -> AnyPublisher<SignUpResponse, any Error> {
        return repository.requestSignUp(params: data)
    }
    
    func checkEmailDuplication(params: [String : Any]) -> AnyPublisher<Bool, any Error> {
        return checkEmailDuplicationUseCase.execute(params: params)
    }
    
    func checkNickNameDuplication(params: [String : Any]) -> AnyPublisher<Bool, any Error> {
        return checkNickNameDuplicationUseCase.execute(params: params)
    }
}
