//
//  ItemRepositoryImpl.swift
//  Baobab
//
//  Created by 이정훈 on 7/25/24.
//

import Combine
import Foundation

final class ItemRepositoryImpl: RemoteRepository, ItemRepository {
    func fetchItemList(for status: ItemStatus) -> AnyPublisher<[Item], any Error> {
        let apiEndPoint = Bundle.main.requestURL + "/goods?status=" + status.rawValue
        
        return dataSource.sendGetRequest(to: apiEndPoint, resultType: ItemStatusResponseDTO.self)
            .map { dto in
                dto.body.map {
                    Item(id: $0.id,
                         name: $0.name,
                         category: $0.category,
                         quantity: $0.quantity,
                         basicImages: $0.basicImages.map { image in image.imageURL },
                         defectImages: $0.faultImages.map { image in image.imageURL })
                }
            }
            .eraseToAnyPublisher()
    }
}
