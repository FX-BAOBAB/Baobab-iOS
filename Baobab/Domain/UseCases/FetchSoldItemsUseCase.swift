//
//  FetchSoldItemsUseCase.swift
//  Baobab
//
//  Created by 이정훈 on 9/9/24.
//

import Combine

protocol FetchSoldItemsUseCase {
    func execute() -> AnyPublisher<[UsedItem], any Error>
}

final class FetchSoldItemsUsedCaseImpl: FetchUsedItemDetailUseCase, FetchSoldItemsUseCase {
    private let historyRepository: TransactionHistoryRepository
    
    init(usedItemRepository: UsedItemRepository,
         historyRepository: TransactionHistoryRepository) {
        self.historyRepository = historyRepository
        super.init(usedItemRepository: usedItemRepository)
    }
    
    func execute() -> AnyPublisher<[UsedItem], any Error> {
        return historyRepository.fetchSoldItems()
            .flatMap { itemIds -> AnyPublisher<[UsedItem], any Error> in
                self.fetchItemDetail(itemIds: itemIds)
            }
            .eraseToAnyPublisher()
    }
}
