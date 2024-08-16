//
//  ShippingUseCase.swift
//  Baobab
//
//  Created by 이정훈 on 8/15/24.
//

import Combine

protocol ShippingUseCase {
    func fetchStoredItems() -> AnyPublisher<[Item]?, any Error>
    func fetchDefaultAddress() -> AnyPublisher<Address, any Error>
    func fetchAddresses() -> AnyPublisher<[Address], any Error>
}

final class ShippingUseCaseImpl: ShippingUseCase {
    private let fetchItemUseCase: FetchItemUseCase
    private let fetchAddressUseCase: FetchAddressUseCase
    
    init(fetchItemUseCase: FetchItemUseCase, fetchAddressUseCase: FetchAddressUseCase) {
        self.fetchAddressUseCase = fetchAddressUseCase
        self.fetchItemUseCase = fetchItemUseCase
    }
    
    func fetchStoredItems() -> AnyPublisher<[Item]?, any Error> {
        return fetchItemUseCase.execute(for: .stored)
    }
    
    func fetchDefaultAddress() -> AnyPublisher<Address, any Error> {
        return fetchAddressUseCase.executeForDefaultAddress()
    }
    
    func fetchAddresses() -> AnyPublisher<[Address], any Error> {
        return fetchAddressUseCase.executeForAddresses()
    }
}
