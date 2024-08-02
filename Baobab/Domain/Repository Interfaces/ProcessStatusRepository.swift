//
//  ProcessStatusRepository.swift
//  Baobab
//
//  Created by 이정훈 on 7/31/24.
//

import Combine

protocol ProcessStatusRepository {
    func fetchReceivingStatus(for id: Int) -> AnyPublisher<ProcessStatus, any Error>
    func fetchShippingStatus(for id: Int) -> AnyPublisher<ProcessStatus, any Error>
    func fetchReturnStatus(for id: Int) -> AnyPublisher<ProcessStatus, any Error>
}
