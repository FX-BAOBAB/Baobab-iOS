//
//  ShippingApplicationRepositoryImpl.swift
//  Baobab
//
//  Created by 이정훈 on 8/19/24.
//

import Combine
import Foundation

final class ShippingApplicationRepositoryImpl: RemoteRepository, ShippingApplicationRepository {
    func requestShipping(params: [String: Any]) -> AnyPublisher<Bool, any Error> {
        let apiEndPoint = Bundle.main.requestURL + "/shipping"
        
        return dataSource.sendPostRequest(to: apiEndPoint, with: params, resultType: ShippingApplicationResponseDTO.self)
            .map { dto in
                if dto.result.resultCode == 200 {
                    return true
                }
                
                return false
            }
            .eraseToAnyPublisher()
    }
}
