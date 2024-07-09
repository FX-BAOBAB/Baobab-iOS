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
    func execute(data: [String: Any]) -> AnyPublisher<SignUpResponse, any Error>
}

//MARK: - SignUpUseCaseImpl
final class SignUpUseCaseImpl: SignUpUseCase {
    private let repository: SignUpRepository
    private let fetchGeoCodeUseCase: FetchGeoCodeUseCase
    
    init(repository: SignUpRepository,fetchGeoCodeUseCase: FetchGeoCodeUseCase) {
        self.repository = repository
        self.fetchGeoCodeUseCase = fetchGeoCodeUseCase
    }
    
    func execute(data: [String: Any]) -> AnyPublisher<SignUpResponse, any Error> {
        return repository.requestSignUp(param: data)
    }
    
    func fetchGeoCode(of address: String) -> AnyPublisher<MKCoordinateRegion, any Error> {
        return fetchGeoCodeUseCase.execute(for: address)
    }
}
