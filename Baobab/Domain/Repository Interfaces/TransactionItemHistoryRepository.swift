//
//  TransactionItemHistoryRepository.swift
//  Baobab
//
//  Created by 이정훈 on 9/9/24.
//

import Combine

protocol TransactionItemHistoryRepository {
    /**
     사용자가 판매한 물품 정보를 가져오는 함수
     */
    func fetchSoldItems() -> AnyPublisher<[Int]?, any Error>
    
    /**
     사용자가 구매한 물품 정보를 가져오는 함수
     */
    func fetchPurchasedItems() -> AnyPublisher<[Int]?, any Error>
}
