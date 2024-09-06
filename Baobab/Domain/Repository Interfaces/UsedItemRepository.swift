//
//  UsedItemRegistrationRepository.swift
//  Baobab
//
//  Created by 이정훈 on 8/21/24.
//

import Combine

protocol UsedItemRepository {    
    /**
     중고 전환 신청 + 판매글 작성 함수
     >  자신이 소유한 물품을 중고 상태로 전환하는 함수
    */
    func register(params: [String: Any]) -> AnyPublisher<Bool, any Error>

    /**
     중고 물품 전체 조회 함수
     >  중고거래 탭에서 보여주기 위한 중고 물품 리스트를 가져오는 함수
    */
    func fetchAllUsedItems() -> AnyPublisher<[Int]?, any Error>
    
    /**
     다음 중고 물품 페이지 조회 함수
     > 무한 스크롤에서 마지막 게시물 다음의 중고 물품을 조회하기 위한 함수
     */
    func fetchNextUsedItems(after id: Int) -> AnyPublisher<[Int]?, any Error>
    
    /**
     중고 물품 검색 함수
     > 키워드를 통해 중고 물품 리스트를 가져오는 함수
     */
    func fetchSearchedUsedItems(keyword: String) -> AnyPublisher<[Int]?, any Error>
    
    /**
     중고 물품 아이디로 상세 조회 함수
     >  중고 물품 아이디로 물품 정보 상세 조회하는 함수
     */
    func fetchUsedItemDetail(itemId: Int) -> AnyPublisher<UsedItem, any Error>
}
