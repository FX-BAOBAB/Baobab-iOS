//
//  DownloadImageUseCase.swift
//  Baobab
//
//  Created by 이정훈 on 9/16/24.
//

import Combine
import Foundation

protocol DownloadImageUseCase {
    func fetchImageData(for url: URL) -> AnyPublisher<Data, any Error>
}

class DownloadImageUseCaseImpl: DownloadImageUseCase {
    let repository: ImageRepository
    
    init(repository: ImageRepository) {
        self.repository = repository
    }
    
    func fetchImageData(for url: URL) -> AnyPublisher<Data, any Error> {
        return repository.download(for: url)
    }
}
