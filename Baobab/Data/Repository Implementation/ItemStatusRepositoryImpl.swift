//
//  ItemStatusRepositoryImpl.swift
//  Baobab
//
//  Created by 이정훈 on 8/23/24.
//

import Combine
import Foundation

final class ItemStatusRepositoryImpl: RemoteRepository, ItemStatusRepository {
    func convertStatus(id: Int) -> AnyPublisher<Bool, any Error> {
        let apiEndPoint = Bundle.main.testURL + "/goods/" + String(id)
        
        return dataSource.sendPostRequest(to: apiEndPoint, with: nil, resultType: UpdateResponseDTO.self)
            .map {
                if $0.result.resultCode == 200 {
                    return true
                }
                
                return false
            }
            .eraseToAnyPublisher()
    }
}
