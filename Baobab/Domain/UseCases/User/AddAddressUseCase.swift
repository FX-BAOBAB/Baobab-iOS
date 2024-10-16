//
//  AddAddressUseCase.swift
//  Baobab
//
//  Created by 이정훈 on 8/27/24.
//

import Combine

protocol AddAddressUseCase {
    func execute(params: [String: Any]) -> AnyPublisher<Bool, any Error>
}

final class AddAddressUseCaseImpl: AddAddressUseCase {
    private let repository: UserRepository
    
    init(repository: UserRepository) {
        self.repository = repository
    }
    
    func execute(params: [String: Any]) -> AnyPublisher<Bool, any Error> {
        return repository.addNewAddress(params: params)
    }
}
