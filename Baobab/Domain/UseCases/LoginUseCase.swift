//
//  LoginUseCase.swift
//  Baobab
//
//  Created by 이정훈 on 7/10/24.
//

import Combine

protocol LoginUseCase {
    func execute(params: [String: Any]) -> AnyPublisher<Bool, any Error>
}

final class LoginUseCaseImpl: LoginUseCase {
    private let fetchTokenUseCase: FetchTokenUseCase
    private let repository: LoginRepository
    
    init(fetchTokenUseCase: FetchTokenUseCase, repository: LoginRepository) {
        self.fetchTokenUseCase = fetchTokenUseCase
        self.repository = repository
    }
    
    func execute(params: [String : Any]) -> AnyPublisher<Bool, any Error> {
        repository.login(params: params)
            .flatMap { [weak self] loginResponse -> AnyPublisher<Bool, Never> in
                guard let self,
                      let accessToken = loginResponse.accessToken,
                      let refreshToken = loginResponse.refreshToken,
                      loginResponse.result == true else {
                    return Just(false).eraseToAnyPublisher()
                }
                
                return fetchTokenUseCase.executeTokenSave(token: accessToken, for: "accessToken")
                    .combineLatest(fetchTokenUseCase.executeTokenSave(token: refreshToken, for: "refreshToken"))
                    .map { accessTokenResult, refreshTokenResult in
                        //access 토큰과 refresh 토큰이 모두 정상적으로 저장된 경우 true 반환
                        if accessTokenResult && refreshTokenResult {
                            return true
                        } else {
                            return false
                        }
                    }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
