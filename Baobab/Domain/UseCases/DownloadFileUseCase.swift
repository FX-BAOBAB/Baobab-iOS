//
//  DownloadFileUseCase.swift
//  Baobab
//
//  Created by 이정훈 on 10/7/24.
//

import Combine
import Foundation

protocol DownloadFileUseCase {
    func downloadFile(url: String) -> AnyPublisher<URL, any Error>
}

final class DownloadFileUseCaseImpl: DownloadFileUseCase {
    enum FileDownloadError: Error {
        case invalidURL
    }
    
    private let repository: FileDownloadRepository
    
    init(repository: FileDownloadRepository) {
        self.repository = repository
    }
    
    func downloadFile(url: String) -> AnyPublisher<URL, any Error> {
        guard let url = URL(string: url) else {
            //유효하지 않은 url은 Fail 전달
            return Fail(error: FileDownloadError.invalidURL)
                .eraseToAnyPublisher()
        }
        
        return repository.download(for: url)
            .flatMap { data -> AnyPublisher<URL, any Error> in
                return self.saveFile(data)
            }
            .eraseToAnyPublisher()
    }
    
    private func saveFile(_ data: Data) -> AnyPublisher<URL, any Error> {
        let directory = getDocumentsDir().appendingPathExtension("model.usdz")
        
        do {
            try data.write(to: directory)
            
            return Just(directory)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch {
            print(error)
            
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
    }
}
