//
//  FileDataSource.swift
//  Baobab
//
//  Created by 이정훈 on 9/16/24.
//

import Combine
import Alamofire
import Foundation

protocol FileDataSource {
    func downloadFile(_ url: URL) async throws -> Data
    func downloadFile(_ url: URL) -> AnyPublisher<Data, any Error>
}

final class FileDataSourceImpl: FileDataSource {
    func downloadFile(_ url: URL) async throws -> Data {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(url, method: .get)
                .responseData { response in
                    switch response.result {
                    case .success(let imageData):
                        continuation.resume(returning: imageData)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
        }
    }
    
    func downloadFile(_ url: URL) -> AnyPublisher<Data, any Error> {
            return Future { promise in
                AF.request(url, method: .get)
                    .responseData { response in
                        switch response.result {
                        case .success(let imageData):
                            promise(.success(imageData))
                        case .failure(let error):
                            promise(.failure(error))
                        }
                    }
            }
            .eraseToAnyPublisher()
        }
}
