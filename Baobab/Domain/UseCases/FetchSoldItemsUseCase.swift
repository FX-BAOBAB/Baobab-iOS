//
//  FetchSoldItemsUseCase.swift
//  Baobab
//
//  Created by 이정훈 on 9/9/24.
//

import Combine

protocol FetchSoldItemsUseCase {
    func execute() -> AnyPublisher<[SimpleUsedItem], any Error>
}

final class FetchSoldItemsUsedCaseImpl: FetchUsedItemDetailUseCase, FetchSoldItemsUseCase {
    private let historyRepository: TransactionItemHistoryRepository
    
    init(usedItemRepository: UsedItemRepository,
         historyRepository: TransactionItemHistoryRepository) {
        self.historyRepository = historyRepository
        super.init(usedItemRepository: usedItemRepository)
    }
    
    func execute() -> AnyPublisher<[SimpleUsedItem], any Error> {
        return historyRepository.fetchSoldItems()
            .map {
                guard let usedItem = $0 else {
                    return []
                }
                
                return usedItem
            }
            .eraseToAnyPublisher()
    }
}
