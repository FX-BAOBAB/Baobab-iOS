//
//  SetupInitialViewUseCase.swift
//  Baobab
//
//  Created by 이정훈 on 8/27/24.
//

import Combine

protocol SetupInitialViewUseCase {
    func executeTokenDeletion() -> AnyPublisher<Bool, any Error>
    func executeFetchingUserInfo() -> AnyPublisher<UserInfo, any Error>
}

final class SetupInitialViewUseCaseImpl: SetupInitialViewUseCase {
    private let fetchTokenUseCase: FetchTokenUseCase
    private let fetchUserInfoUseCase: FetchUserInfoUseCase
    
    init(fetchTokenUseCase: FetchTokenUseCase, fetchUserInfoUseCase: FetchUserInfoUseCase) {
        self.fetchTokenUseCase = fetchTokenUseCase
        self.fetchUserInfoUseCase = fetchUserInfoUseCase
    }
    
    func executeTokenDeletion() -> AnyPublisher<Bool, any Error> {
        return fetchTokenUseCase.executeTokenDelete(for: "accessToken")
            .merge(with: fetchTokenUseCase.executeTokenDelete(for: "refreshToken"))
            .collect()    //두 upstream의 결과를 Array에 수집
            .flatMap { result -> AnyPublisher<Bool, any Error> in
                if result.allSatisfy({ $0 == true }) {
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
    
    func executeFetchingUserInfo() -> AnyPublisher<UserInfo, any Error> {
        return fetchUserInfoUseCase.execute()
    }
}
