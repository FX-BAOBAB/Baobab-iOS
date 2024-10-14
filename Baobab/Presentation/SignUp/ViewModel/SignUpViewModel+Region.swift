//
//  SignUpViewModel+Region.swift
//  Baobab
//
//  Created by 이정훈 on 7/1/24.
//

import MapKit
import Combine

extension SignUpViewModel {
    func calculateMapCoordinates() {
        $searchedAddress
            .dropFirst(1)
            .flatMap { [weak self] address -> AnyPublisher<MKCoordinateRegion, Error> in
                guard let self else {
                    return Empty<MKCoordinateRegion, Error>().eraseToAnyPublisher()
                }
                
                return fetchGeoCodeUseCase.execute(for: address)
            }
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Request to fetch geocode is finished")
                case .failure(let error):
                    print("SignUpViewModel.calculateMapCoordinates() - ", error)
                }
            }, receiveValue: { [weak self] region in
                self?.searchedAddressRegion = region
            })
            .store(in: &cancellables)
    }
}
