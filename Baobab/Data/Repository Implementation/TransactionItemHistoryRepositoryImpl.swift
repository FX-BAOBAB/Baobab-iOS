//
//  TransactionItemHistoryRepositoryImpl.swift
//  Baobab
//
//  Created by 이정훈 on 9/9/24.
//

import Combine
import Foundation

final class TransactionItemHistoryRepositoryImpl: RemoteRepository, TransactionItemHistoryRepository {
    func fetchSoldItems() -> AnyPublisher<[SimpleUsedItem]?, any Error> {
        let apiEndPoint = Bundle.main.warehouseURL + "/usedgoods?status=SOLD"
        
        return dataSource.sendGetRequest(to: apiEndPoint, resultType: UsedItemsResponseDTO.self)
            .map { dto in
                dto.body?.map {
//                    $0.usedGoodsID
                    SimpleUsedItem(id: $0.usedGoodsID,
                                   title: $0.title,
                                   price: $0.price,
                                   postedAt: $0.postedAt,
                                   item: self.toImage(goods: $0.goods))
                }
            }
            .eraseToAnyPublisher()
    }
    
    func fetchSaleItems() -> AnyPublisher<[SimpleUsedItem]?, any Error> {
        let apiEndPoint = Bundle.main.warehouseURL + "/usedgoods?status=REGISTERED"
        
        return dataSource.sendGetRequest(to: apiEndPoint, resultType: UsedItemsResponseDTO.self)
            .map { dto in
                dto.body?.map {
//                    $0.usedGoodsID
                    SimpleUsedItem(id: $0.usedGoodsID,
                                   title: $0.title,
                                   price: $0.price,
                                   postedAt: $0.postedAt,
                                   item: self.toImage(goods: $0.goods))
                }
            }
            .eraseToAnyPublisher()
    }
    
    func fetchPurchasedItems() -> AnyPublisher<[SimpleUsedItem]?, any Error> {
        let apiEndPoint = Bundle.main.warehouseURL + "/order"
        
        return dataSource.sendGetRequest(to: apiEndPoint, resultType: UsedItemsResponseDTO.self)
            .map { dto in
                dto.body?.map {
                    SimpleUsedItem(id: $0.usedGoodsID,
                                   title: $0.title,
                                   price: $0.price,
                                   postedAt: $0.postedAt,
                                   item: self.toImage(goods: $0.goods))
                }
            }
            .eraseToAnyPublisher()
    }
    
    private func toImage(goods: Goods) -> Item {
        Item(id: goods.id,
             name: goods.name,
             category: goods.category,
             status: ItemStatus(rawValue: goods.status),
             quantity: goods.quantity,
             basicImages: toFileData(goods.basicImages),
             defectImages: toFileData(goods.faultImages),
             arImages: toFileData(goods.arImages))
    }
    
    private func toFileData(_ files: [FileMetaData]) -> [FileData] {
        return files.map {
            FileData(imageURL: $0.imageURL, caption: $0.caption)
        }
    }
}
