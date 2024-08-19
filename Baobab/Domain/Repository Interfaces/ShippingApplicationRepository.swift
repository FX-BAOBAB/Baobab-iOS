//
//  ShippingApplicationRepository.swift
//  Baobab
//
//  Created by 이정훈 on 8/19/24.
//

import Combine

protocol ShippingApplicationRepository {
    func requestShipping(params: [String: Any]) -> AnyPublisher<Bool, any Error>
}
