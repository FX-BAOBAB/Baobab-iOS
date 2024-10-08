//
//  ARModelRepositoryImpl.swift
//  Baobab
//
//  Created by 이정훈 on 10/7/24.
//

import Combine
import Foundation

final class ARModelRepositoryImpl: ARModelRepository {
    private let localDataSource: LocalDataSource
    
    init(localDataSource: LocalDataSource) {
        self.localDataSource = localDataSource
    }
    
    func save(data: Data) async throws -> URL {
        let directoryPath = getDocumentsDir().appendingPathExtension("model.usdz")
        try await localDataSource.save(data: data, to: directoryPath)
        
        return directoryPath
    }
    
    func delete(at url: URL) async throws {
        try await localDataSource.delete(at: url)
    }
    
}
