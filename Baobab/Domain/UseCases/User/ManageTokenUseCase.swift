//
//  ManageTokenUseCase.swift
//  Baobab
//
//  Created by 이정훈 on 7/10/24.
//

import Combine

class ManageTokenUseCase {
    let repository: TokenRepositroy
    
    init(repository: TokenRepositroy) {
        self.repository = repository
    }
}

protocol FetchTokenUseCase {
    func execute(for account: String) -> AnyPublisher<String?, Never>
}

final class FetchTokenUseCaseImpl: ManageTokenUseCase, FetchTokenUseCase {
    func execute(for account: String) -> AnyPublisher<String?, Never> {
        return repository.read(for: account)
    }
}

protocol SaveTokenUseCase {
    func execute(token: String, for account: String) -> AnyPublisher<Bool, Never>
}

final class SaveTokenUseCaseImpl: ManageTokenUseCase, SaveTokenUseCase {
    func execute(token: String, for account: String) -> AnyPublisher<Bool, Never> {
        return repository.create(token: token, for: account)
    }
}

protocol UpdateLocalTokenUseCase {
    func execute(token: String, for account: String) -> AnyPublisher<Bool, Never>
}

final class UpdateLocalTokenUseCaseImpl: ManageTokenUseCase, UpdateLocalTokenUseCase {
    func execute(token: String, for account: String) -> AnyPublisher<Bool, Never> {
        return repository.update(token: token, for: account)
    }
}

protocol DeleteTokenUseCase {
    func execute() -> AnyPublisher<[Bool], Never>
}

final class DeleteTokenUseCaseImpl: ManageTokenUseCase, DeleteTokenUseCase {
    func execute() -> AnyPublisher<[Bool], Never> {
        return repository.delete(for: "accessToken")
            .merge(with: repository.delete(for: "refreshToken"))
            .collect()
            .eraseToAnyPublisher()
    }
}
