//
//  FetchAddressUseCase.swift
//  Baobab
//
//  Created by 이정훈 on 7/12/24.
//

import Combine

protocol FetchAddressUseCase {
    func executeForDefaultAddress() -> AnyPublisher<Address, any Error>
    func executeForAddresses() -> AnyPublisher<[Address], any Error>
}

final class FetchAddressUseCaseImpl: FetchAddressUseCase {
    private let repository: UserRepository
    
    init(repository: UserRepository) {
        self.repository = repository
    }
    
    func executeForDefaultAddress() -> AnyPublisher<Address, any Error> {
        return repository.fetchDefaultAddress()
    }
    
    func executeForAddresses() -> AnyPublisher<[Address], any Error> {
        return repository.fetchAddresses()
    }
}
