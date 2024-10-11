//
//  FetchTransactionHistoryUseCase.swift
//  Baobab
//
//  Created by 이정훈 on 9/11/24.
//

import Combine

protocol FetchTransactionHistoryUseCase {
    func execute(usedItemId: Int) -> AnyPublisher<TransactionHistory, any Error>
}

final class FetchTransactionHistoryUseCaseImpl: FetchTransactionHistoryUseCase {
    private let transactionHistoryRepository: TransactionHistoryRepository
    private let userRepository: UserRepository
    
    init(transactionHistoryRepository: TransactionHistoryRepository,
         userRepository: UserRepository) {
        self.transactionHistoryRepository = transactionHistoryRepository
        self.userRepository = userRepository
    }
    
    func execute(usedItemId: Int) -> AnyPublisher<TransactionHistory, any Error> {
        return transactionHistoryRepository.fetchHistory(usedItemId: usedItemId)
            .flatMap { history -> AnyPublisher<TransactionHistory, any Error> in
                return self.userRepository.fetchUserInfo(userId: history.buyerId)
                    .combineLatest(self.userRepository.fetchUserInfo(userId: history.sellerId)) { buyerInfo, sellerInfo in
                        TransactionHistory(
                            usedGoodsOrderID: history.usedGoodsID,
                            buyer: buyerInfo,
                            seller: sellerInfo,
                            createdAt: history.createdAt,
                            usedGoodsID: history.usedGoodsID
                        )
                    }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
