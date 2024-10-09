//
//  ARModelRepositoryImpl.swift
//  Baobab
//
//  Created by 이정훈 on 10/7/24.
//

import Combine
import Foundation

final class LocalFileRepositoryImpl: LocalFileRepository {
    private let localDataSource: LocalDataSource
    
    init(localDataSource: LocalDataSource) {
        self.localDataSource = localDataSource
    }
    
    func save(data: Data) async throws -> URL {
        let filePath = getDocumentsDir().appendingPathComponent("\(Date().timeIntervalSince1970).usdz")
        try await localDataSource.save(data: data, to: filePath)
        
        return filePath
    }
    
    func delete(at url: URL) async throws {
        try await localDataSource.delete(at: url)
    }
    
}
