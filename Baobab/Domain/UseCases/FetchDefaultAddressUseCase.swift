//
//  FetchDefaultAddressUseCase.swift
//  Baobab
//
//  Created by 이정훈 on 5/29/24.
//

import Combine

protocol FetchDefaultAddressUseCase {
    func execute() -> AnyPublisher<Address, Error>
}

final class FetchDefaultAddressUseCaseImpl {
    private let repository: UserRepository
    
    init(repository: UserRepository) {
        self.repository = repository
    }
}

extension FetchDefaultAddressUseCaseImpl: FetchDefaultAddressUseCase {
    func execute() -> AnyPublisher<Address, any Error> {
        return repository.fetchDefaultAddress()
    }
}
