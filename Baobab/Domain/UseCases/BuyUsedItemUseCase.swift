//
//  BuyUsedItemUseCase.swift
//  Baobab
//
//  Created by 이정훈 on 9/7/24.
//

import Combine
import Foundation

protocol BuyUsedItemUseCase {
    func execute(for id: Int) -> AnyPublisher<Bool, any Error>
    func fetchBasicImageData(for urls: [String]) -> AnyPublisher<[Data], any Error>
    func fetchDefectImageData(for imageData: [FileData]) -> AnyPublisher<[(Data, String)], any Error>
    func fetchModelFile(urlString: String) async throws -> URL
}

final class BuyUsedItemUseCaseImpl: BuyUsedItemUseCase {
    private let downloadImageUseCase: DownloadImageUseCase
    private let downloadFileUseCase: DownloadFileUseCase
    private let repository: UsedItemRepository
    
    init(downloadImageUseCase: DownloadImageUseCase, downloadFileUseCase: DownloadFileUseCase, repository: UsedItemRepository) {
        self.downloadImageUseCase = downloadImageUseCase
        self.downloadFileUseCase = downloadFileUseCase
        self.repository = repository
    }
    
    func execute(for usedItemId: Int) -> AnyPublisher<Bool, any Error> {
        return repository.buyUsedItem(id: usedItemId)
    }
    
    func fetchBasicImageData(for urls: [String]) -> AnyPublisher<[Data], any Error> {
        return downloadImageUseCase.fetchBasicImageData(for: urls)
    }
    
    func fetchDefectImageData(for imageData: [FileData]) -> AnyPublisher<[(Data, String)], any Error> {
        return downloadImageUseCase.fetchDefectImageData(for: imageData)
    }
    
    func fetchModelFile(urlString: String) async throws -> URL {
        return try await downloadFileUseCase.downloadFile(urlString: urlString)
    }
}
