//
//  ModelRepository.swift
//  Baobab
//
//  Created by 이정훈 on 10/7/24.
//

import Combine
import Foundation

protocol ARModelRepository {
    func save(data: Data) async throws -> URL
    func delete(at url: URL) async throws
}
