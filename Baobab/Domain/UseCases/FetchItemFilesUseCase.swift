//
//  FetchItemFilesUseCase.swift
//  Baobab
//
//  Created by 이정훈 on 10/7/24.
//

import Combine
import Foundation

protocol FetchItemFilesUseCase {
    func fetchBasicImageData(for basicIamges: [String]) -> AnyPublisher<[Data], any Error>
    func fetchDefectImageData(for defects: [FileData]) -> AnyPublisher<[(Data, String)], any Error>
    func fetchModelFile(urlString: String) async throws -> URL
}

final class FetchItemFilesUseCaseImpl: FetchItemFilesUseCase {
    private let downloadImageUseCase: DownloadImageUseCase
    private let downloadFileUseCase: DownloadFileUseCase
    
    init(downloadImageUsecase: DownloadImageUseCase, downloadFileUsecase: DownloadFileUseCase) {
        self.downloadImageUseCase = downloadImageUsecase
        self.downloadFileUseCase = downloadFileUsecase
    }
    
    func fetchBasicImageData(for basicIamges: [String]) -> AnyPublisher<[Data], any Error> {
        return downloadImageUseCase.fetchBasicImageData(for: basicIamges)
    }
    
    func fetchDefectImageData(for defects: [FileData]) -> AnyPublisher<[(Data, String)], any Error> {
        return downloadImageUseCase.fetchDefectImageData(for: defects)
    }
    
    func fetchModelFile(urlString: String) async throws -> URL {
        return try await downloadFileUseCase.downloadFile(urlString: urlString)
    }
}
