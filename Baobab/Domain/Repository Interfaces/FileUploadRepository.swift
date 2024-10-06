//
//  FileUploadRepository.swift
//  Baobab
//
//  Created by 이정훈 on 7/13/24.
//

import Combine
import Foundation

protocol FileUploadRepository {
    func upload(params: [String: Any], fileExtension: String, mimeType: String) -> AnyPublisher<FileUploadResponse, any Error>
    func upload(params: [String: Any], fileExtension: String, mimeType: String) -> AnyPublisher<[FileUploadResponse], any Error>
}
