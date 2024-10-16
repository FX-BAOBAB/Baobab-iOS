//
//  UserViewModel+Region.swift
//  Baobab
//
//  Created by 이정훈 on 8/27/24.
//

import MapKit
import Combine

extension UserInfoViewModel {
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
                    print("The request to fetch the geocode has been completed")
                case .failure(let error):
                    print("ReceivingViewModel.calculateMapCoordinates() - ", error)
                }
            }, receiveValue: { [weak self] region in
                self?.searchedAddressRegion = region
            })
            .store(in: &cancellables)
    }
}
