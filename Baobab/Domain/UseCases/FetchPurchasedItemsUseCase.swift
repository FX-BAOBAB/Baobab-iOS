//
//  FetchPurchasedItemsUseCase.swift
//  Baobab
//
//  Created by 이정훈 on 9/9/24.
//

import Combine

protocol FetchPurchasedItemsUseCase {
    func execute() -> AnyPublisher<[UsedItem], any Error>
}

final class FetchPurchasedItemsUseCaseImpl: FetchUsedItemDetailUseCase, FetchPurchasedItemsUseCase {
    private let historyRepository: TransactionHistoryRepository
    
    init(usedItemRepository: UsedItemRepository,
        historyRepository: TransactionHistoryRepository) {
        self.historyRepository = historyRepository
        super.init(usedItemRepository: usedItemRepository)
    }
    
    func execute() -> AnyPublisher<[UsedItem], any Error> {
        return historyRepository.fetchPurchasedItems()
            .flatMap { itemIds -> AnyPublisher<[UsedItem], any Error> in
                self.fetchItemDetail(itemIds: itemIds)
            }
            .eraseToAnyPublisher()
    }
}
