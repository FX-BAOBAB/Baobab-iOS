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
    func execute(deliveryDate: Date, deliveryAddress: String, items: [Item]) -> AnyPublisher<Bool, any Error>
}

final class ShippingUseCaseImpl: ShippingUseCase {
    private let fetchItemUseCase: FetchItemUseCase
    private let fetchAddressUseCase: FetchAddressUseCase
    private let fetchGeoCodeUseCase: FetchGeoCodeUseCase
    private let repository: ShippingApplicationRepository
    
    init(fetchItemUseCase: FetchItemUseCase, 
         fetchAddressUseCase: FetchAddressUseCase,
         fetchGeoCodeUseCase: FetchGeoCodeUseCase,
         repository: ShippingApplicationRepository) {
        self.fetchAddressUseCase = fetchAddressUseCase
        self.fetchItemUseCase = fetchItemUseCase
        self.fetchGeoCodeUseCase = fetchGeoCodeUseCase
        self.repository = repository
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
    
    func execute(deliveryDate: Date, deliveryAddress: String, items: [Item]) -> AnyPublisher<Bool, any Error> {
        let params = [
            "result": [
                "resultCode": 0,
                "resultMessage": "string",
                "resultDescription": "string"
            ],
            "body": [
                "deliveryDate": deliveryDate.toISOFormat(),
                "deliveryAddress": deliveryAddress,
                "goodsIdList": getItemIdList(items: items)
            ]
        ] as [String: Any]
        
        return repository.requestShipping(params: params)
    }
    
    private func getItemIdList(items: [Item]) -> [Int] {
        return items.map {
            $0.id
        }
    }
}
