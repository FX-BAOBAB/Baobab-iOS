//
//  FetchTokenUseCase.swift
//  Baobab
//
//  Created by 이정훈 on 7/10/24.
//

import Combine

protocol FetchTokenUseCase {
    func executeTokenSave(token: String, for account: String) -> AnyPublisher<Bool, Never>
    func executeTokenRead(for account: String) -> AnyPublisher<String?, Never>
    func executeTokenUpdate(token: String, for account: String) -> AnyPublisher<Bool, Never>
    func executeTokenDelete(for account: String) -> AnyPublisher<Bool, Never>
}

final class FetchTokenUseCaseImpl: FetchTokenUseCase {
    private let repository: TokenRepositroy
    
    init(repository: TokenRepositroy) {
        self.repository = repository
    }
    
    func executeTokenSave(token: String, for account: String) -> AnyPublisher<Bool, Never> {
        return repository.create(token: token, for: account)
    }
    
    func executeTokenRead(for account: String) -> AnyPublisher<String?, Never> {
        return repository.read(for: account)
    }
    
    func executeTokenUpdate(token: String, for account: String) -> AnyPublisher<Bool, Never> {
        return repository.update(token: token, for: account)
    }
    
    func executeTokenDelete(for account: String) -> AnyPublisher<Bool, Never> {
        return repository.delete(for: account)
    }
    
    
}
