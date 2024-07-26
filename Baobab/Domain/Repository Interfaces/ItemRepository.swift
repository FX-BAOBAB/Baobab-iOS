//
//  ItemRepository.swift
//  Baobab
//
//  Created by 이정훈 on 7/25/24.
//

import Combine

protocol ItemRepository {
    func fetchItemList(for status: ItemStatus) -> AnyPublisher<[Item], any Error>
}
