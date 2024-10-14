//
//  FetchPurchasedItemsUseCase.swift
//  Baobab
//
//  Created by 이정훈 on 9/9/24.
//

import Combine

protocol FetchPurchasedItemsUseCase {
    func execute() -> AnyPublisher<[SimpleUsedItem], any Error>
}

final class FetchPurchasedItemsUseCaseImpl: FetchUsedItemDetailUseCase, FetchPurchasedItemsUseCase {
    private let historyRepository: TransactionItemHistoryRepository
    
    init(usedItemRepository: UsedItemRepository,
        historyRepository: TransactionItemHistoryRepository) {
        self.historyRepository = historyRepository
        super.init(usedItemRepository: usedItemRepository)
    }
    
    func execute() -> AnyPublisher<[SimpleUsedItem], any Error> {
        return historyRepository.fetchPurchasedItems()
            .map {
                guard let usedItem = $0 else {
                    return []
                }
                
                return usedItem
            }
            .eraseToAnyPublisher()
    }
}
