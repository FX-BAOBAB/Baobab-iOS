//
//  FetchUserInfoUseCase.swift
//  Baobab
//
//  Created by 이정훈 on 7/22/24.
//

import Combine

protocol FetchUserInfoUseCase {
    func execute() -> AnyPublisher<UserInfo, any Error>
}

final class FetchuserInfoUserCaseImpl: FetchUserInfoUseCase {
    private let repository: UserRepository
    
    init(repository: UserRepository) {
        self.repository = repository
    }
    
    func execute() -> AnyPublisher<UserInfo, any Error> {
        return repository.fetchUserInfo()
    }
}
