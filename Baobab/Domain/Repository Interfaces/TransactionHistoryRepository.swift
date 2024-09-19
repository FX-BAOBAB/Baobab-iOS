//
//  TransactionHistoryRepository.swift
//  Baobab
//
//  Created by 이정훈 on 9/11/24.
//

import Combine

protocol TransactionHistoryRepository {
    func fetchHistory(usedItemId: Int) -> AnyPublisher<SimpleTransactionHistory, any Error>
}
