//
//  ReceivingUseCase.swift
//  Baobab
//
//  Created by 이정훈 on 5/29/24.
//

import MapKit
import Combine

protocol ReceivingUseCase {
    func fetchGeoCode(_ address: String) -> AnyPublisher<MKCoordinateRegion, Error>
}

final class ReceivingUseCaseImpl {
    private let fetchGeoCodeUseCase: FetchGeoCodeUseCase
    
    init(fetchGeoCodeUseCase: FetchGeoCodeUseCase) {
        self.fetchGeoCodeUseCase = fetchGeoCodeUseCase
    }
}

extension ReceivingUseCaseImpl: ReceivingUseCase {
    func fetchGeoCode(_ address: String) -> AnyPublisher<MKCoordinateRegion, Error> {
        return fetchGeoCodeUseCase.execute(for: address)
    }
}
