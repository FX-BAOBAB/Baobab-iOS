//
//  ProcessStatusRepositoryImpl.swift
//  Baobab
//
//  Created by 이정훈 on 7/31/24.
//

import Combine
import Foundation

final class ProcessStatusRepositoryImpl: RemoteRepository, ProcessStatusRepository {
    func fetchReceivingStatus(for id: Int) -> AnyPublisher<ProcessStatus, any Error> {
        let apiEndPoint = Bundle.main.requestURL + "/receiving/\(id)"
        
        return dataSource.sendGetRequest(to: apiEndPoint, resultType: ProcessStatusResponseDTO.self)
            .map {
                ProcessStatus(total: $0.body.total,
                              status: $0.body.status,
                              current: $0.body.current)
            }
            .eraseToAnyPublisher()
    }
    
    func fetchShippingStatus(for id: Int) -> AnyPublisher<ProcessStatus, any Error> {
        let apiEndPoint = Bundle.main.requestURL + "/shipping/process/\(id)"
        
        return dataSource.sendGetRequest(to: apiEndPoint, resultType: ProcessStatusResponseDTO.self)
            .map {
                ProcessStatus(total: $0.body.total,
                              status: $0.body.status,
                              current: $0.body.current)
            }
            .eraseToAnyPublisher()
    }
    
    func fetchReturnStatus(for id: Int) -> AnyPublisher<ProcessStatus, any Error> {
        let apiEndPoint = Bundle.main.requestURL + "/"
        
        return dataSource.sendGetRequest(to: apiEndPoint, resultType: ProcessStatusResponseDTO.self)
            .map {
                ProcessStatus(total: $0.body.total,
                              status: $0.body.status,
                              current: $0.body.current)
            }
            .eraseToAnyPublisher()
    }
}
