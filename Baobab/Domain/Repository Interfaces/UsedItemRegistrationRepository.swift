//
//  UsedItemRegistrationRepository.swift
//  Baobab
//
//  Created by 이정훈 on 8/21/24.
//

import Combine

protocol UsedItemRegistrationRepository {
    func register(params: [String: Any]) -> AnyPublisher<Bool, any Error>
}
