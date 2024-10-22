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
        let apiEndPoint = Bundle.main.warehouseOpenURL + "/usedgoods?status=REGISTERED"
        
        return dataSource.sendGetRequest(to: apiEndPoint, resultType: UsedItemsResponseDTO.self)
            .map { dto in
                dto.body?.map {
                    return $0.usedGoodsID
                }
            }
            .eraseToAnyPublisher()
    }
    
    func fetchNextUsedItems(after id: Int) -> AnyPublisher<[Int]?, any Error> {
        let apiEndPoint = Bundle.main.warehouseOpenURL + "/usedgoods?usedGoodsId=\(id)&status=REGISTERED"
        
        return dataSource.sendGetRequest(to: apiEndPoint, resultType: UsedItemsResponseDTO.self)
            .map { dto in
                dto.body?.map {
                    return $0.usedGoodsID
                }
            }
            .eraseToAnyPublisher()
    }
    
    func fetchSearchedUsedItems(keyword: String) -> AnyPublisher<[Int]?, any Error> {
        let apiEndPoint = Bundle.main.warehouseOpenURL + "/usedgoods?keyword=\(keyword)&status=REGISTERED"
        
        return dataSource.sendGetRequest(to: apiEndPoint, resultType: UsedItemsResponseDTO.self)
            .map { dto in
                dto.body?.map {
                    return $0.usedGoodsID
                }
            }
            .eraseToAnyPublisher()
    }
    
    func fetchUsedItemDetail(itemId: Int) -> AnyPublisher<UsedItem, any Error> {
        let apiEndPoint = Bundle.main.warehouseOpenURL + "/usedgoods/\(itemId)"
        
        return dataSource.sendGetRequest(to: apiEndPoint, resultType: UsedItemDetailResponseDTO.self)
            .map {
                UsedItem(id: itemId,
                         title: $0.body.title,
                         price: $0.body.price,
                         description: $0.body.description,
                         postedAt: $0.body.postedAt,
                         item: self.toItem(goods: $0.body.goods))
            }
            .eraseToAnyPublisher()
    }
    
    func buyUsedItem(id: Int) -> AnyPublisher<Bool, any Error> {
        //타입 캐스팅을 하지 않으면 protocol extension에 기본 정의된 함수가 호출됨
        guard let dataSource = dataSource as? RemoteDataSourceImpl else {
            return Just(false)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        let apiEndPoint = Bundle.main.warehouseURL + "/order/\(id)"
        
        return dataSource.sendPostRequest(to: apiEndPoint, resultType: PurchaseUsedItemsResponseDTO.self)
            .map {
                if $0.result.resultCode == 200 {
                    return true
                }
                
                return false
            }
            .eraseToAnyPublisher()
    }
    
    private func toFileData(_ files: [FileMetaData]) -> [FileData] {
        return files.map {
            FileData(imageURL: $0.imageURL, caption: $0.caption)
        }
    }
    
    private func toItem(goods: Goods) -> Item {
        return Item(id: goods.id,
                    name: goods.name,
                    category: goods.category,
                    status: ItemStatus(rawValue: goods.status),
                    quantity: goods.quantity,
                    basicImages: self.toFileData(goods.basicImages),
                    defectImages: self.toFileData(goods.faultImages),
                    arImages: self.toFileData(goods.arImages))
    }
}
