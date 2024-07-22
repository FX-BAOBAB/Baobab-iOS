//
//  UploadImageUseCase.swift
//  Baobab
//
//  Created by 이정훈 on 7/13/24.
//

import Combine
import Foundation

protocol UploadImageUseCase {
    func execute(params: [String: Any]) -> AnyPublisher<ImageUploadResponse, any Error>
    func execute(params: [String: Any]) -> AnyPublisher<[ImageUploadResponse], any Error>
}

final class UploadImageUseCaseImpl: UploadImageUseCase {
    private let repository: ImageRepository
    
    init(repository: ImageRepository) {
        self.repository = repository
    }
    
    func execute(params: [String: Any]) -> AnyPublisher<ImageUploadResponse, any Error> {
        return repository.upload(params: params)
    }
    
    func execute(params: [String: Any]) -> AnyPublisher<[ImageUploadResponse], any Error> {
        return repository.upload(params: params)
    }
}
