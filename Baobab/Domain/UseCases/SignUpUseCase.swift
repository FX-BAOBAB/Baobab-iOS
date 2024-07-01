//
//  SignUpUseCase.swift
//  Baobab
//
//  Created by 이정훈 on 7/1/24.
//

import MapKit
import Combine

//MARK: - SignUpUseCase Protocol
protocol SignUpUseCase {
    func fetchGeoCode(of address: String) -> AnyPublisher<MKCoordinateRegion, any Error>
}

//MARK: - SignUpUseCaseImpl
final class SignUpUseCaseImpl: SignUpUseCase {
    private let fetchGeoCodeUseCase: FetchGeoCodeUseCase
    
    init(fetchGeoCodeUseCase: FetchGeoCodeUseCase) {
        self.fetchGeoCodeUseCase = fetchGeoCodeUseCase
    }
    
    func fetchGeoCode(of address: String) -> AnyPublisher<MKCoordinateRegion, any Error> {
        return fetchGeoCodeUseCase.execute(for: address)
    }
}
