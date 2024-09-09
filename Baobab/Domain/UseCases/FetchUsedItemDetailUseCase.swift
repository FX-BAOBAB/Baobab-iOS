//
//  FetchUsedItemDetailUseCase.swift
//  Baobab
//
//  Created by 이정훈 on 9/9/24.
//

import Combine

class FetchUsedItemDetailUseCase {
    let usedItemRepository: UsedItemRepository
    
    init(usedItemRepository: UsedItemRepository) {
        self.usedItemRepository = usedItemRepository
    }
    
    func fetchItemDetail(itemIds: [Int]?) -> AnyPublisher<[UsedItem], any Error> {
        // 중고 물품 조회를 통해 중고 물품 아이디를 가져옴
        // 가져온 중고 물품 아이디를 통해 중고 물품 상세 정보(title, price, description 등)을 가져옴
        var publishers = [AnyPublisher<UsedItem, any Error>]()
        
        itemIds?.forEach { itemId in
            publishers.append(self.usedItemRepository.fetchUsedItemDetail(itemId: itemId))
        }
        
        return Publishers.MergeMany(publishers)
            .collect()
            .eraseToAnyPublisher()
    }
}
