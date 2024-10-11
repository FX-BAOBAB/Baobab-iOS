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
                         basicImages: self.toFileData($0.basicImages),
                         defectImages: self.toFileData($0.faultImages),
                         arImages: self.toFileData($0.arImages))
                }
            }
            .eraseToAnyPublisher()
    }
    
    private func toFileData(_ files: [FileMetaData]) -> [FileData] {
        return files.map {
            FileData(imageURL: $0.imageURL, caption: $0.caption)
        }
    }
}
