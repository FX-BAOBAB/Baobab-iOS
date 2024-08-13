//
//  RemoteTokenRepository.swift
//  Baobab
//
//  Created by 이정훈 on 8/12/24.
//

import Combine

protocol RemoteTokenRepository {
    func fetchNewAccessToken(refreshToken: String) -> AnyPublisher<String, any Error>
}
