//
//  FetchFormUseCase.swift
//  Baobab
//
//  Created by 이정훈 on 7/29/24.
//

import Combine

protocol FetchFormUseCase {
    func executeForReceiving() -> AnyPublisher<[FormData], any Error>
    func executeForReturn() -> AnyPublisher<[FormData], any Error>
    func executeForShipping() -> AnyPublisher<[FormData], any Error>
}

final class FetchFormUseCaseImpl: FetchFormUseCase {
    private let repository: FormRepository
    
    init(repository: FormRepository) {
        self.repository = repository
    }
    
    func executeForReceiving() -> AnyPublisher<[FormData], any Error> {
        return repository.fetchReceivingForms()
    }
    
    func executeForReturn() -> AnyPublisher<[FormData], any Error> {
        return repository.fetchReturnForms()
    }
    
    func executeForShipping() -> AnyPublisher<[FormData], any Error> {
        return repository.fetchShippingForms()
    }
}
