//
//  ShippingUseCase.swift
//  Baobab
//
//  Created by 이정훈 on 8/15/24.
//

import MapKit
import Combine

protocol ShippingUseCase {
    func fetchStoredItems() -> AnyPublisher<[Item]?, any Error>
    func fetchDefaultAddress() -> AnyPublisher<Address, any Error>
    func fetchAddresses() -> AnyPublisher<[Address], any Error>
    func fetchGeoCode(of address: String) -> AnyPublisher<MKCoordinateRegion, any Error>
}

final class ShippingUseCaseImpl: ShippingUseCase {
    private let fetchItemUseCase: FetchItemUseCase
    private let fetchAddressUseCase: FetchAddressUseCase
    private let fetchGeoCodeUseCase: FetchGeoCodeUseCase
    
    init(fetchItemUseCase: FetchItemUseCase, fetchAddressUseCase: FetchAddressUseCase, fetchGeoCodeUseCase: FetchGeoCodeUseCase) {
        self.fetchAddressUseCase = fetchAddressUseCase
        self.fetchItemUseCase = fetchItemUseCase
        self.fetchGeoCodeUseCase = fetchGeoCodeUseCase
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
    
    func fetchGeoCode(of address: String) -> AnyPublisher<MKCoordinateRegion, any Error> {
        return fetchGeoCodeUseCase.execute(for: address)
    }
}
