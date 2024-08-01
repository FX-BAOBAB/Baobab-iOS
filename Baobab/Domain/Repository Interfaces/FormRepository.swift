//
//  FormRepository.swift
//  Baobab
//
//  Created by 이정훈 on 7/29/24.
//

import Combine

protocol FormRepository {
    ///입고 요청서를 가져오는 함수
    func fetchReceivingForms() -> AnyPublisher<[ReceivingForm], any Error>
    
    ///반품 요청서를 가져오는 함수
    func fetchReturnForms() -> AnyPublisher<[ReceivingForm], any Error>
    
    ///출고 요청서를 가져오는 함수
    func fetchShippingForms() -> AnyPublisher<[ShippingForm], any Error>
}
