//
//  AbandonOwnershipUseCase.swift
//  Baobab
//
//  Created by 이정훈 on 8/24/24.
//

import Combine

protocol AbandonOwnershipUseCase {
    func execute(formId: Int) -> AnyPublisher<Bool, any Error>
}

final class AbandonOwnershipUseCaseImpl: AbandonOwnershipUseCase {
    private let repository: ReceivingRepository
    
    init(repository: ReceivingRepository) {
        self.repository = repository
    }
    
    func execute(formId: Int) -> AnyPublisher<Bool, any Error> {
        return repository.abandonOwnership(of: formId)
    }
}
