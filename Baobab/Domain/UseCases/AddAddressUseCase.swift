//
//  AddAddressUseCase.swift
//  Baobab
//
//  Created by 이정훈 on 8/27/24.
//

import MapKit
import Combine

protocol AddAddressUseCase {
    func fetchDefaultAddress() -> AnyPublisher<Address, any Error>
    func fetchAddresses() -> AnyPublisher<[Address], any Error>
    func fetchGeoCode(of address: String) -> AnyPublisher<MKCoordinateRegion, any Error>
    func execute(params: [String: Any]) -> AnyPublisher<Bool, any Error>
}

final class AddAddressUseCaseImpl: AddAddressUseCase {
    private let fetchAddressUseCase: FetchAddressUseCase
    private let fetchGeoCodeUseCase: FetchGeoCodeUseCase
    private let repository: UserRepository
    
    init(fetchAddressUseCase: FetchAddressUseCase,
         fetchGeoCodeUseCase: FetchGeoCodeUseCase,
         repository: UserRepository) {
        self.fetchAddressUseCase = fetchAddressUseCase
        self.fetchGeoCodeUseCase = fetchGeoCodeUseCase
        self.repository = repository
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
    
    func execute(params: [String: Any]) -> AnyPublisher<Bool, any Error> {
        return repository.addNewAddress(params: params)
    }
}
