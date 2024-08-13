//
//  UpdateAccessTokenUseCase.swift
//  Baobab
//
//  Created by 이정훈 on 8/12/24.
//

import Combine

protocol UpdateAccessTokenUseCase {
    func execute(refreshToken: String) -> AnyPublisher<String, any Error>
}

final class UpdateAccessTokenUseCaseImpl: UpdateAccessTokenUseCase {
    private let repository: RemoteTokenRepository
    
    init(repository: RemoteTokenRepository) {
        self.repository = repository
    }
    
    func execute(refreshToken: String) -> AnyPublisher<String, any Error> {
        return repository.fetchNewAccessToken(refreshToken: refreshToken)
    }
}
