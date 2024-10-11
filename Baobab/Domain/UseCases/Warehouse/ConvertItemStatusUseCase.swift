//
//  ConvertItemStatusUseCase.swift
//  Baobab
//
//  Created by 이정훈 on 8/23/24.
//

import Combine

protocol ConvertItemStatusUseCase {
    func execute(for id: Int) -> AnyPublisher<Bool, any Error>
}

final class ConvertItemStatusUseCaseImpl: ConvertItemStatusUseCase {
    let repository: ItemStatusRepository
    
    init(repository: ItemStatusRepository) {
        self.repository = repository
    }
    
    func execute(for id: Int) -> AnyPublisher<Bool, any Error> {
        return repository.convertStatus(id: id)
    }
}
