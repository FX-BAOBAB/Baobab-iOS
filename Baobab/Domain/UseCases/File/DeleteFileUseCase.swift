//
//  DeleteFileUseCase.swift
//  Baobab
//
//  Created by 이정훈 on 10/9/24.
//

import Foundation

protocol DeleteFileUseCase {
    func delete(at filePath: URL) async throws
}

final class DeleteFileUseCaseImpl: DeleteFileUseCase {
    private let localFileRepository: LocalFileRepository
    
    init(localFileRepository: LocalFileRepository) {
        self.localFileRepository = localFileRepository
    }
    
    func delete(at filePath: URL) async throws {
        try await localFileRepository.delete(at: filePath)
    }
}
