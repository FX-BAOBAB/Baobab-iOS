//
//  FetchSaleItemsUseCase.swift
//  Baobab
//
//  Created by 이정훈 on 9/12/24.
//

import Combine

protocol FetchSaleItemsUseCase {
    func execute() -> AnyPublisher<[SimpleUsedItem], any Error>
}

final class FetchSaleItemsUseCaseImpl: FetchUsedItemDetailUseCase, FetchSaleItemsUseCase {
    private let historyRepository: TransactionItemHistoryRepository
    
    init(usedItemRepository: UsedItemRepository,
         historyRepository: TransactionItemHistoryRepository) {
        self.historyRepository = historyRepository
        super.init(usedItemRepository: usedItemRepository)
    }
    
    func execute() -> AnyPublisher<[SimpleUsedItem], any Error> {
        return historyRepository.fetchSaleItems()
            .map {
                guard let usedItem = $0 else {
                    return []
                }
                
                return usedItem
            }
            .eraseToAnyPublisher()
    }
}
