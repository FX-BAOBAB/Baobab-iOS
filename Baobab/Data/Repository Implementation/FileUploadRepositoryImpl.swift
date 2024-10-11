//
//  ImageRepositoryImpl.swift
//  Baobab
//
//  Created by 이정훈 on 7/13/24.
//

import Combine
import Foundation

final class FileUploadRepositoryImpl: RemoteRepository, FileUploadRepository {    
    ///다중 이미지 업로드 메서드
    func upload(params: [String : Any], fileExtension: String, mimeType: String) -> AnyPublisher<[FileUploadResponse], any Error> {
        let apiEndPoint = Bundle.main.imageURL + "/image/list"
        
        return dataSource.sendUploadRequest(to: apiEndPoint,
                                            with: params,
                                            resultType: MultipleFileUploadResponseDTO.self,
                                            fileExtension: fileExtension,
                                            mimeType: mimeType)
            .map { dto in
                dto.body.map {
                    FileUploadResponse(id: $0.id,
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
    func upload(params: [String: Any], fileExtension: String, mimeType: String) -> AnyPublisher<FileUploadResponse, any Error> {
        let apiEndPoint = Bundle.main.imageURL + "/image"
        
        return dataSource.sendUploadRequest(to: apiEndPoint,
                                            with: params,
                                            resultType: SingleFileUploadResponseDTO.self,
                                            fileExtension: fileExtension,
                                            mimeType: mimeType)
            .map {
                FileUploadResponse(id: $0.body.id,
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
