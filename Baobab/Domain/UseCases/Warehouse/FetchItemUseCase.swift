//
//  FetchItemUseCase.swift
//  Baobab
//
//  Created by 이정훈 on 7/25/24.
//

import Combine

protocol FetchItemUseCase {
    func execute(for status: ItemStatus) -> AnyPublisher<[Item]?, any Error>
}

final class FetchItemUseCaseImpl: FetchItemUseCase {
    private let repository: ItemRepository
    
    init(repository: ItemRepository) {
        self.repository = repository
    }
    
    func execute(for status: ItemStatus) -> AnyPublisher<[Item]?, any Error> {
        return repository.fetchItemList(for: status)
    }
}
