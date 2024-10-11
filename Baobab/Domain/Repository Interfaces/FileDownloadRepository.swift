//
//  FileDownloadRepository.swift
//  Baobab
//
//  Created by 이정훈 on 10/7/24.
//

import Combine
import Foundation

protocol FileDownloadRepository {
    func download(for url: URL) async throws -> Data
    func download(for url: URL) -> AnyPublisher<Data, any Error>
}
