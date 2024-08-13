//
//  LoginUseCase.swift
//  Baobab
//
//  Created by 이정훈 on 7/10/24.
//

import Combine

protocol LoginUseCase {
    func execute(params: [String: Any]) -> AnyPublisher<Bool, any Error>
    func updateRefreshToken() -> AnyPublisher<Bool, any Error>
    func deleteToken() -> AnyPublisher<Bool, any Error>
}

final class LoginUseCaseImpl: LoginUseCase {
    private let fetchTokenUseCase: FetchTokenUseCase    //local Keychain에서 가져오는 인스턴스
    private let updateTokenUseCase: UpdateTokenUseCase    //remote에서 가져오는 인스턴스
    private let repository: LoginRepository
    
    init(fetchTokenUseCase: FetchTokenUseCase, updateAccessTokenUseCase: UpdateTokenUseCase, repository: LoginRepository) {
        self.fetchTokenUseCase = fetchTokenUseCase
        self.updateTokenUseCase = updateAccessTokenUseCase
        self.repository = repository
    }
    
    func execute(params: [String : Any]) -> AnyPublisher<Bool, any Error> {
        return deleteToken()    //로그인 전에 남아있는 token 정보 삭제
            .flatMap { [weak self] _ -> AnyPublisher<LoginResponse, any Error> in
                guard let self else {
                    return Fail(error: FetchError.noReference)
                        .eraseToAnyPublisher()
                }
                
                return repository.login(params: params)
            }
            .flatMap { [weak self] loginResponse -> AnyPublisher<Bool, Never> in
                guard let self,
                      let accessToken = loginResponse.accessToken,
                      let refreshToken = loginResponse.refreshToken,
                      loginResponse.result == true else {
                    return Just(false)
                        .eraseToAnyPublisher()
                }
                
                return fetchTokenUseCase.executeTokenSave(token: accessToken, for: "accessToken")
                    .merge(with: fetchTokenUseCase.executeTokenSave(token: refreshToken, for: "refreshToken"))
                    .collect()
                    .map { results in
                        //access 토큰과 refresh 토큰이 모두 정상적으로 저장된 경우 true 반환
                        if results.allSatisfy({ $0 == true }) {
                            return true
                        } else {
                            return false
                        }
                    }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    func updateRefreshToken() -> AnyPublisher<Bool, any Error> {
//        return fetchTokenUseCase.executeTokenRead(for: "refreshToken")
//            .flatMap { [weak self] refreshToken -> AnyPublisher<String, any Error> in
//                guard let self, let refreshToken else {
//                    return Fail(error: FetchError.noReference)
//                        .eraseToAnyPublisher()
//                }
//                
//                //refreshToken으로 새로운 accessToken 요청
//                return updateAccessTokenUseCase.execute(refreshToken: refreshToken)
//            }
//            .flatMap { [weak self] accessToken -> AnyPublisher<Bool, any Error> in                
//                guard let self else {
//                    return Fail(error: FetchError.noReference)
//                        .eraseToAnyPublisher()
//                }
//                
//                //새로 발급 받은 accessToken을 Keychain에 업데이트
//                return fetchTokenUseCase.executeTokenUpdate(token: accessToken, for: "accessToken")
//                    .setFailureType(to: Error.self)
//                    .eraseToAnyPublisher()
//            }
//            .eraseToAnyPublisher()
        return Just(true)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func deleteToken() -> AnyPublisher<Bool, any Error> {
        return fetchTokenUseCase.executeTokenDelete(for: "accessToken")
            .merge(with: fetchTokenUseCase.executeTokenDelete(for: "refreshToken"))
            .collect()
            .flatMap { results -> AnyPublisher<Bool, any Error> in
                if results.allSatisfy({ $0 == true }) {
                    return Just(true)
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
                }
                
                return Just(false)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
