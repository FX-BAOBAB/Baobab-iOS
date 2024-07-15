//
//  ImageRepository.swift
//  Baobab
//
//  Created by 이정훈 on 7/13/24.
//

import Combine

protocol ImageRepository {
    func upload(params: [String: Any]) -> AnyPublisher<ImageUploadResponse, any Error>
    func upload(params: [String: Any]) -> AnyPublisher<[ImageUploadResponse], any Error>
}
