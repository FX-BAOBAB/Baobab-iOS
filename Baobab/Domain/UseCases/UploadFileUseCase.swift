//
//  UploadFileUseCase.swift
//  Baobab
//
//  Created by 이정훈 on 7/13/24.
//

import Combine
import Foundation

protocol UploadFileUseCase {
    func execute(params: [String: Any], fileExtension: String, mimeType: String) -> AnyPublisher<FileUploadResponse, any Error>
    func execute(params: [String: Any], fileExtension: String, mimeType: String) -> AnyPublisher<[FileUploadResponse], any Error>
}

final class UploadFileUseCaseImpl: UploadFileUseCase {
    private let repository: FileRepository
    
    init(repository: FileRepository) {
        self.repository = repository
    }
    
    func execute(params: [String: Any], fileExtension: String, mimeType: String) -> AnyPublisher<FileUploadResponse, any Error> {
        return repository.upload(params: params, fileExtension: fileExtension, mimeType: mimeType)
    }
    
    func execute(params: [String: Any], fileExtension: String, mimeType: String) -> AnyPublisher<[FileUploadResponse], any Error> {
        return repository.upload(params: params, fileExtension: fileExtension, mimeType: mimeType)
    }
}
