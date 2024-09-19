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
     다음 중고 물품 페이지 조회 함수
     > 무한 스크롤에서 마지막 게시물 다음의 중고 물품을 조회하기 위한 함수
     */
    func execute(after id: Int) -> AnyPublisher<[UsedItem], any Error>
}

final class FetchUsedItemUseCaseImpl: FetchUsedItemDetailUseCase, FetchUsedItemUseCase {    
    func execute() -> AnyPublisher<[UsedItem], any Error> {
        return usedItemRepository.fetchAllUsedItems()
            .flatMap { itemIds -> AnyPublisher<[UsedItem], any Error> in
                self.fetchItemDetail(itemIds: itemIds)
            }
            .eraseToAnyPublisher()
    }
    
    func execute(after id: Int) -> AnyPublisher<[UsedItem], any Error> {
        return usedItemRepository.fetchNextUsedItems(after: id)
            .flatMap { itemIds -> AnyPublisher<[UsedItem], any Error> in
                self.fetchItemDetail(itemIds: itemIds)
            }
            .eraseToAnyPublisher()
    }
}
