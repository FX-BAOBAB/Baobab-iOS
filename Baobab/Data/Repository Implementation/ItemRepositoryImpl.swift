//
//  ItemRepositoryImpl.swift
//  Baobab
//
//  Created by 이정훈 on 7/25/24.
//

import Combine
import Foundation

final class ItemRepositoryImpl: RemoteRepository, ItemRepository {
    func fetchItemList(for status: ItemStatus) -> AnyPublisher<[Item]?, any Error> {
        let apiEndPoint = Bundle.main.warehouseURL + "/goods?status=" + status.rawValue
        
        return dataSource.sendGetRequest(to: apiEndPoint, resultType: ItemResponseDTO.self)
            .map { dto in
                dto.body?.map {
                    Item(id: $0.id,
                         name: $0.name,
                         category: $0.category, 
                         status: ItemStatus(rawValue: $0.status),
                         quantity: $0.quantity,
                         basicImages: self.toImageData($0.basicImages),
                         defectImages: self.toImageData($0.faultImages))
                }
            }
            .eraseToAnyPublisher()
    }
    
    private func toImageData(_ image: [ImageMetaData]) -> [ImageData] {
        return image.map {
            ImageData(imageURL: $0.imageURL, caption: $0.caption)
        }
    }
}
