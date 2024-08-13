//
//  UpdateAccessTokenUseCase.swift
//  Baobab
//
//  Created by 이정훈 on 8/12/24.
//

import Combine

protocol UpdateTokenUseCase {
    func execute(refreshToken: String) -> AnyPublisher<String, any Error>
}

final class UpdateAccessTokenUseCaseImpl: UpdateTokenUseCase {
    private let repository: RemoteTokenRepository
    
    init(repository: RemoteTokenRepository) {
        self.repository = repository
    }
    
    func execute(refreshToken: String) -> AnyPublisher<String, any Error> {
        return repository.fetchNewAccessToken(refreshToken: refreshToken)
    }
}
