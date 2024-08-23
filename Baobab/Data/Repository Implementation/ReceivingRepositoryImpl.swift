//
//  ReceivingRepositoryImpl.swift
//  Baobab
//
//  Created by 이정훈 on 7/15/24.
//

import Combine
import Foundation

final class ReceivingRepositoryImpl: RemoteRepository, ReceivingRepository {
    func requestReceiving(params: [String : Any]) -> AnyPublisher<Bool, any Error> {
        let apiEndPoint = Bundle.main.warehouseURL + "/receiving"
        
        return dataSource.sendPostRequest(to: apiEndPoint, with: params, resultType: ReceivingResponseDTO.self)
            .map {
                if $0.result.resultCode == 200 {
                    return true
                } else {
                    return false
                }
            }
            .eraseToAnyPublisher()
    }
}
