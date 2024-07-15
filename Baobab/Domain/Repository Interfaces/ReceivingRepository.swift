//
//  ReceivingRepository.swift
//  Baobab
//
//  Created by 이정훈 on 7/15/24.
//

import Combine

protocol ReceivingRepository {
    func requestReceiving(params: [String: Any]) -> AnyPublisher<Bool, any Error>
}
