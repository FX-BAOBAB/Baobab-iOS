//
//  ImageRepositoryImpl.swift
//  Baobab
//
//  Created by 이정훈 on 7/13/24.
//

import Combine
import Foundation

final class ImageRepositoryImpl: RemoteRepository, ImageRepository {
    ///다중 이미지 업로드 메서드
    func upload(params: [String : Any]) -> AnyPublisher<[ImageUploadResponse], any Error> {
        let apiEndPoint = Bundle.main.requestURL + "/async/image/list"
        
        return dataSource.sendUploadRequest(to: apiEndPoint, with: params, resultType: MultipleImageUploadResponseDTO.self)
            .map { dto in
                dto.body.map {
                    ImageUploadResponse(id: $0.id,
                                        serverName: $0.serverName,
                                        originalName: $0.originalName,
                                        imageUrl: $0.imageURL,
                                        caption: $0.caption,
                                        kind: $0.kind,
                                        itemId: $0.goodsID)
                }
            }
            .eraseToAnyPublisher()
    }
    
    ///단일 이미지 업로드 메서드
    func upload(params: [String: Any]) -> AnyPublisher<ImageUploadResponse, any Error> {
        let apiEndPoint = Bundle.main.requestURL + "/async/image"
        
        return dataSource.sendPostRequest(to: apiEndPoint, with: params, resultType: SingleImageUploadResponseDTO.self)
            .map {
                ImageUploadResponse(id: $0.body.id,
                                    serverName: $0.body.serverName,
                                    originalName: $0.body.originalName,
                                    imageUrl: $0.body.imageURL,
                                    caption: $0.body.caption,
                                    kind: $0.body.kind,
                                    itemId: $0.body.goodsID)
            }
            .eraseToAnyPublisher()
    }
}
