//
//  DownloadFileUseCase.swift
//  Baobab
//
//  Created by 이정훈 on 10/7/24.
//

import Combine
import Foundation

protocol DownloadFileUseCase {
    func downloadFile(urlString: String) async throws -> URL
}

final class DownloadFileUseCaseImpl: DownloadFileUseCase {
    enum FileDownloadError: Error {
        case invalidURL
    }
    
    private let fileDownloadRepository: FileDownloadRepository
    private let arModelRepository: ARModelRepository
    
    init(fileDownloadRepository: FileDownloadRepository, arModelRepository: ARModelRepository) {
        self.fileDownloadRepository = fileDownloadRepository
        self.arModelRepository = arModelRepository
    }
    
    func downloadFile(urlString: String) async throws -> URL {
        guard let url = URL(string: urlString) else {
            //유효하지 않은 url은 Fail 전달
            throw FileDownloadError.invalidURL
        }
        
        //서버에서 가져온 Modle File
        let data = try await fileDownloadRepository.download(for: url)
        
        //저장 후 URL 반환
        return try await arModelRepository.save(data: data)
    }
}
