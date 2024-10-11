//
//  FetchSearchedUsedItemsUseCase.swift
//  Baobab
//
//  Created by 이정훈 on 9/7/24.
//

import Combine

protocol FetchSearchedUsedItemsUseCase {
    /**
     중고 물품 검색 함수
     > 키워드를 통해 중고 물품 리스트를 가져오는 함수
     */
    func execute(keyword: String) -> AnyPublisher<[UsedItem], any Error>
}

final class FetchSearchedUsedItemsUseCaseImpl: FetchUsedItemDetailUseCase, FetchSearchedUsedItemsUseCase {    
    func execute(keyword: String) -> AnyPublisher<[UsedItem], any Error> {
        return usedItemRepository.fetchSearchedUsedItems(keyword: keyword)
            .flatMap { itemIds -> AnyPublisher<[UsedItem], any Error> in
                self.fetchItemDetail(itemIds: itemIds)
            }
            .eraseToAnyPublisher()
    }
}
