//
//  RegisterAsUsedItemUseCase.swift
//  Baobab
//
//  Created by 이정훈 on 8/21/24.
//

import Combine

protocol RegisterAsUsedItemUseCase {
    func execute(params: [String: Any]) -> AnyPublisher<Bool, any Error>
}

final class RegisterAsUsedItemUseCaseImpl: RegisterAsUsedItemUseCase {
    private let repository: UsedItemRepository
    
    init(repository: UsedItemRepository) {
        self.repository = repository
    }
    
    func execute(params: [String: Any]) -> AnyPublisher<Bool, any Error> {
        return repository.register(params: params)
    }
}
