//
//  BuyUsedItemUseCase.swift
//  Baobab
//
//  Created by 이정훈 on 9/7/24.
//

import Combine

protocol BuyUsedItemUseCase {
    func execute(for id: Int) -> AnyPublisher<Bool, any Error>
}

final class BuyUsedItemUseCaseImpl: BuyUsedItemUseCase {
    private let repository: UsedItemRepository
    
    init(repository: UsedItemRepository) {
        self.repository = repository
    }
    
    func execute(for usedItemId: Int) -> AnyPublisher<Bool, any Error> {
        return repository.buyUsedItem(id: usedItemId)
    }
}
