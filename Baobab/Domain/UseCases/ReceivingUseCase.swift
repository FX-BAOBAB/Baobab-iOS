//
//  ReceivingUseCase.swift
//  Baobab
//
//  Created by 이정훈 on 5/29/24.
//

import MapKit
import Combine

//MARK: - ReceivingUseCase protocol
protocol ReceivingUseCase {
    func fetchDefaultAddress() -> AnyPublisher<Address, any Error>
    func fetchGeoCode(of address: String) -> AnyPublisher<MKCoordinateRegion, any Error>
}

//MARK: - ReceivingUseCaseImpl
final class ReceivingUseCaseImpl {
    private let fetchGeoCodeUseCase: FetchGeoCodeUseCase
    private let fetchDefaultAddressUseCase: FetchDefaultAddressUseCase
    
    init(fetchGeoCodeUseCase: FetchGeoCodeUseCase, fetchDefaultAddressUseCase: FetchDefaultAddressUseCase) {
        self.fetchGeoCodeUseCase = fetchGeoCodeUseCase
        self.fetchDefaultAddressUseCase = fetchDefaultAddressUseCase
    }
}

//MARK: - protocol implementation extension
extension ReceivingUseCaseImpl: ReceivingUseCase {
    func fetchGeoCode(of address: String) -> AnyPublisher<MKCoordinateRegion, any Error> {
        return fetchGeoCodeUseCase.execute(for: address)
    }
    
    func fetchDefaultAddress() -> AnyPublisher<Address, any Error> {
        return fetchDefaultAddressUseCase.execute()
    }
}
