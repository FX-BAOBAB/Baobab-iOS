//
//  ImageDataSource.swift
//  Baobab
//
//  Created by 이정훈 on 9/16/24.
//

import Combine
import Alamofire
import Foundation

protocol ImageDataSource {
    func loadImageData(_ url: URL) -> AnyPublisher<Data, any Error>
}

final class ImageDataSourceImpl: ImageDataSource {
    func loadImageData(_ url: URL) -> AnyPublisher<Data, any Error> {
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
