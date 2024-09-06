//
//  FetchUsedItemUseCase.swift
//  Baobab
//
//  Created by 이정훈 on 9/3/24.
//

import Combine

protocol FetchUsedItemUseCase {
    /**
     중고 물품 전체 조회 함수
     > 중고 거래 탭에서 중고 물품을 조회하기 위한 함수
     */
    func execute() -> AnyPublisher<[UsedItem], any Error>
    
    /**
     중고 물품 검색 함수
     > 키워드를 통해 중고 물품 리스트를 가져오는 함수
     */
    func executeForSearch(keyword: String) -> AnyPublisher<[UsedItem], any Error>
}

final class FetchUsedItemUseCaseImpl: FetchUsedItemUseCase {
    let repository: UsedItemRepository
    
    init(repository: UsedItemRepository) {
        self.repository = repository
    }
    
    func execute() -> AnyPublisher<[UsedItem], any Error> {
        return repository.fetchAllUsedItems()
            .flatMap { itemIds -> AnyPublisher<[UsedItem], any Error> in
                // 중고 물품 조회를 통해 중고 물품 아이디를 가져옴
                // 가져온 중고 물품 아이디를 통해 중고 물품 상세 정보(title, price, description 등)을 가져옴
                var publishers = [AnyPublisher<UsedItem, any Error>]()
                
                itemIds?.forEach { itemId in
                    publishers.append(self.repository.fetchUsedItemDetail(itemId: itemId))
                }
                
                return Publishers.MergeMany(publishers)
                    .collect()
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    func executeForSearch(keyword: String) -> AnyPublisher<[UsedItem], any Error> {
        return repository.fetchSearchedUsedItems(keyword: keyword)
            .flatMap { itemIds -> AnyPublisher<[UsedItem], any Error> in
                // 중고 물품 조회를 통해 중고 물품 아이디를 가져옴
                // 가져온 중고 물품 아이디를 통해 중고 물품 상세 정보(title, price, description 등)을 가져옴
                var publishers = [AnyPublisher<UsedItem, any Error>]()
                
                itemIds?.forEach { itemId in
                    publishers.append(self.repository.fetchUsedItemDetail(itemId: itemId))
                }
                
                return Publishers.MergeMany(publishers)
                    .collect()
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
