//
//  FetchProcessStatus.swift
//  Baobab
//
//  Created by 이정훈 on 7/31/24.
//

import Combine

protocol FetchProcessStatusUseCase {
    func executeForReceiving(id: Int) -> AnyPublisher<ProcessStatus, any Error>
    func executeForShipping(id: Int) -> AnyPublisher<ProcessStatus, any Error>
}

final class FetchProcessStatusUseCaseImpl: FetchProcessStatusUseCase {
    private let repository: ProcessStatusRepository
    
    init(repository: ProcessStatusRepository) {
        self.repository = repository
    }
    
    func executeForReceiving(id: Int) -> AnyPublisher<ProcessStatus, any Error> {
        return repository.fetchReceivingStatus(for: id)
    }
    
    func executeForShipping(id: Int) -> AnyPublisher<ProcessStatus, any Error> {
        return repository.fetchShippingStatus(for: id)
    }
}
