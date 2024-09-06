//
//  UsedItemRegistrationRepositoryImpl.swift
//  Baobab
//
//  Created by 이정훈 on 8/21/24.
//

import Combine
import Foundation

final class UsedItemRepositoryImpl: RemoteRepository, UsedItemRepository {
    func register(params: [String : Any]) -> AnyPublisher<Bool, any Error> {
        let apiEndPoint = Bundle.main.warehouseURL + "/usedgoods"
        
        return dataSource.sendPostRequest(to: apiEndPoint, with: params, resultType: UpdateResponseDTO.self)
            .map {
                if $0.result.resultCode == 200 {
                    return true
                }
                
                return false
            }
            .eraseToAnyPublisher()
    }
    
    func fetchAllUsedItems() -> AnyPublisher<[Int]?, any Error> {
        let apiEndPoint = Bundle.main.warehouseOpenURL + "/usedgoods"
        
        return dataSource.sendGetRequest(to: apiEndPoint, resultType: UsedItemsResponseDTO.self)
            .map { dto in
                dto.body?.map {
                    return $0.usedGoodsID
                }
            }
            .eraseToAnyPublisher()
    }
    
    func fetchSearchedUsedItems(keyword: String) -> AnyPublisher<[Int]?, any Error> {
        let apiEndPoint = Bundle.main.warehouseOpenURL + "/usedgoods?keyword=\(keyword)"
        
        return dataSource.sendGetRequest(to: apiEndPoint, resultType: UsedItemsResponseDTO.self)
            .map { dto in
                dto.body?.map {
                    return $0.usedGoodsID
                }
            }
            .eraseToAnyPublisher()
    }
    
    func fetchUsedItemDetail(itemId: Int) -> AnyPublisher<UsedItem, any Error> {
        let apiEndPoint = Bundle.main.warehouseURL + "/usedgoods/\(itemId)"
        
        return dataSource.sendGetRequest(to: apiEndPoint, resultType: UsedItemDetailResponseDTO.self)
            .map {
                UsedItem(id: $0.body.goods.id,
                         title: $0.body.title,
                         price: $0.body.price,
                         description: $0.body.description,
                         postedAt: $0.body.postedAt,
                         item: self.toItem(goods: $0.body.goods))
            }
            .eraseToAnyPublisher()
    }
    
    private func toImageData(_ image: [ImageMetaData]) -> [ImageData] {
        return image.map {
            ImageData(imageURL: $0.imageURL, caption: $0.caption)
        }
    }
    
    private func toItem(goods: Goods) -> Item {
        return Item(id: goods.id,
                    name: goods.name,
                    category: goods.category,
                    status: ItemStatus(rawValue: goods.status),
                    quantity: goods.quantity,
                    basicImages: self.toImageData(goods.basicImages),
                    defectImages: self.toImageData(goods.faultImages))
    }
}
