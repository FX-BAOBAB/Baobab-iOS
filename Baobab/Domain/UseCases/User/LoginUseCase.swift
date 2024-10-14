//
//  LoginUseCase.swift
//  Baobab
//
//  Created by 이정훈 on 7/10/24.
//

import Combine
import Foundation

protocol LoginUseCase {
    func execute(params: [String: Any]) -> AnyPublisher<Bool, any Error>
    func deleteToken() -> AnyPublisher<Bool, any Error>
}

final class LoginUseCaseImpl: LoginUseCase {
    private let saveTokenUseCase: SaveTokenUseCase    //KeyChain에 Token 저장하는 인스턴스
    private let deleteTokenUseCase: DeleteTokenUseCase    //Keychain에서 Token 삭제하는 인스턴스
    private let repository: LoginRepository
    
    init(saveTokenUseCase: SaveTokenUseCase,
         deleteTokenUseCase: DeleteTokenUseCase,
         repository: LoginRepository) {
        self.saveTokenUseCase = saveTokenUseCase
        self.deleteTokenUseCase = deleteTokenUseCase
        self.repository = repository
    }
    
    func execute(params: [String : Any]) -> AnyPublisher<Bool, any Error> {
        return repository.login(params: params)
            .flatMap { [weak self] loginResponse -> AnyPublisher<Bool, Never> in
                guard let self,
                      let accessToken = loginResponse.accessToken,
                      let refreshToken = loginResponse.refreshToken,
                      loginResponse.result == true else {
                    return Just(false)
                        .eraseToAnyPublisher()
                }
                
                return saveTokenUseCase.execute(token: accessToken, for: "accessToken")
                    .merge(with: saveTokenUseCase.execute(token: refreshToken, for: "refreshToken"))
                    .collect()
                    .map { results in
                        //access 토큰과 refresh 토큰이 모두 정상적으로 저장된 경우 true 반환
                        if results.allSatisfy({ $0 == true }) {
                            UserDefaults.standard.set(true, forKey: "hasToken")    //토큰 저장상태 업데이트
                            
                            return true
                        } else {
                            return false
                        }
                    }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    func deleteToken() -> AnyPublisher<Bool, any Error> {
        return deleteTokenUseCase.execute()
            .flatMap { results -> AnyPublisher<Bool, any Error> in
                if results.allSatisfy({ $0 == true }) {
                    UserDefaults.standard.set(false, forKey: "hasToken")    //토큰 저장 상태 업데이트
                    
                    return Just(true)
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
                }
                
                //기존에 저장된 토큰이 없는 경우 삭제 실패할 수 있음
                return Just(false)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
