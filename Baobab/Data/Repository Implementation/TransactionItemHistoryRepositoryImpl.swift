//
//  TransactionItemHistoryRepositoryImpl.swift
//  Baobab
//
//  Created by 이정훈 on 9/9/24.
//

import Combine
import Foundation

final class TransactionItemHistoryRepositoryImpl: RemoteRepository, TransactionItemHistoryRepository {
    func fetchSoldItems() -> AnyPublisher<[Int]?, any Error> {
        let apiEndPoint = Bundle.main.warehouseURL + "/usedgoods?status=SOLD"
        
        return dataSource.sendGetRequest(to: apiEndPoint, resultType: UsedItemsResponseDTO.self)
            .map { dto in
                dto.body?.map {
                    $0.usedGoodsID
                }
            }
            .eraseToAnyPublisher()
    }
    
    func fetchSaleItems() -> AnyPublisher<[Int]?, any Error> {
        let apiEndPoint = Bundle.main.warehouseURL + "/usedgoods?status=REGISTERED"
        
        return dataSource.sendGetRequest(to: apiEndPoint, resultType: UsedItemsResponseDTO.self)
            .map { dto in
                dto.body?.map {
                    $0.usedGoodsID
                }
            }
            .eraseToAnyPublisher()
    }
    
    func fetchPurchasedItems() -> AnyPublisher<[Int]?, any Error> {
        let apiEndPoint = Bundle.main.warehouseURL + "/order"
        
        return dataSource.sendGetRequest(to: apiEndPoint, resultType: UsedItemsResponseDTO.self)
            .map { dto in
                dto.body?.map {
                    $0.usedGoodsID
                }
            }
            .eraseToAnyPublisher()
    }
}
