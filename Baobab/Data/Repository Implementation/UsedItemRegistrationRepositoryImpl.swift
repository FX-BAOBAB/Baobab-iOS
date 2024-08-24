//
//  UsedItemRegistrationRepositoryImpl.swift
//  Baobab
//
//  Created by 이정훈 on 8/21/24.
//

import Combine
import Foundation

final class UsedItemRegistrationRepositoryImpl: RemoteRepository, UsedItemRegistrationRepository {
    func register(params: [String : Any]) -> AnyPublisher<Bool, any Error> {
        let apiEndPoint = Bundle.main.warehouseURL + "/usedgoods"
        
        return dataSource.sendPostRequest(to: apiEndPoint, with: params, resultType: UpdateResponseDTO.self)
            .map {
                if $0.result.resultCode == 200 {
                    return true
                }
                
                return false
            }
            .eraseToAnyPublisher()
    }
}
