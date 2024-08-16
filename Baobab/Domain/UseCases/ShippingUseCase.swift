//
//  ShippingUseCase.swift
//  Baobab
//
//  Created by 이정훈 on 8/15/24.
//

import Combine

protocol ShippingUseCase {
    func fetchStoredItems() -> AnyPublisher<[Item]?, any Error>
}

final class ShippingUseCaseImpl: ShippingUseCase {
    private let fetchItemUseCase: FetchItemUseCase
    
    init(fetchItemUseCase: FetchItemUseCase) {
        self.fetchItemUseCase = fetchItemUseCase
    }
    
    func fetchStoredItems() -> AnyPublisher<[Item]?, any Error> {
        return fetchItemUseCase.execute(for: .stored)
    }
}
