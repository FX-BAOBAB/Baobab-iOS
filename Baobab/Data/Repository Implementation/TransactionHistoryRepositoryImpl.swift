//
//  TransactionHistoryRepositoryImpl.swift
//  Baobab
//
//  Created by 이정훈 on 9/11/24.
//

import Combine
import Foundation

final class TransactionHistoryRepositoryImpl: RemoteRepository, TransactionHistoryRepository {
    func fetchHistory(usedItemId: Int) -> AnyPublisher<SimpleTransactionHistory, any Error> {
        let apiEndPoint = Bundle.main.warehouseURL + "/order/\(usedItemId)"
        
        return dataSource.sendGetRequest(to: apiEndPoint, resultType: PurchaseUsedItemsResponseDTO.self)
            .map {
                SimpleTransactionHistory(
                    usedGoodsOrderID: $0.body.usedGoodsOrderID,
                    buyerId: $0.body.buyerID,
                    sellerId: $0.body.sellerID,
                    createdAt: $0.body.createdAt,
                    usedGoodsID: $0.body.usedGoodsID
                )
            }
            .eraseToAnyPublisher()
    }
}
