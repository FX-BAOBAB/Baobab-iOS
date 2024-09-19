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
    func fetchBasicImageData(for urls: [String]) -> AnyPublisher<[Data], any Error>
    func fetchDefectImageData(for imageData: [ImageData]) -> AnyPublisher<[(Data, String)], any Error>
}

class DownloadImageUseCaseImpl: DownloadImageUseCase {
    let repository: ImageRepository
    
    init(repository: ImageRepository) {
        self.repository = repository
    }
    
    func fetchImageData(for url: URL) -> AnyPublisher<Data, any Error> {
        return repository.download(for: url)
    }
    
    func fetchBasicImageData(for urls: [String]) -> AnyPublisher<[Data], any Error> {
        var publishers = [AnyPublisher<Data, any Error>]()
        
        for url in urls {
            guard let url = URL(string: url) else {
                continue
            }
            
            publishers.append(fetchImageData(for: url))
        }
        
        return Publishers.MergeMany(publishers)
            .collect()
            .eraseToAnyPublisher()
    }
    
    func fetchDefectImageData(for imageData: [ImageData]) -> AnyPublisher<[(Data, String)], any Error> {
        var publishers = [AnyPublisher<(Data, String), any Error>]()
        
        for i in imageData.indices {
            guard let url = URL(string: imageData[i].imageURL) else {
                continue
            }
            
            publishers.append(fetchImageData(for: url)
                .map {
                    return ($0, imageData[i].caption)
                }
                .eraseToAnyPublisher())
        }
        
        return Publishers.MergeMany(publishers)
            .collect()
            .eraseToAnyPublisher()
    }
}