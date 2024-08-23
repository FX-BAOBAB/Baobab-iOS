//
//  ItemStatusRepository.swift
//  Baobab
//
//  Created by 이정훈 on 8/23/24.
//

import Combine

protocol ItemStatusRepository {
    func convertStatus(id: Int) -> AnyPublisher<Bool, any Error>
}
