//
//  ReceivingViewModel+Region.swift
//  Baobab
//
//  Created by 이정훈 on 5/28/24.
//

import MapKit
import Combine

extension ReceivingViewModel {
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
                    print("ReceivingViewModel.calculateMapCoordinates() - ", error)
                }
            }, receiveValue: { [weak self] region in
                self?.searchedAddressRegion = region
            })
            .store(in: &cancellables)
        
        $selectedAddress
            .dropFirst(1)
            .flatMap { [weak self] addressDetail -> AnyPublisher<MKCoordinateRegion, Error> in
                guard let self, let addressDetail else {
                    return Empty<MKCoordinateRegion, Error>().eraseToAnyPublisher()
                }
                
                return fetchGeoCodeUseCase.execute(for: addressDetail.address)
            }
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Request to fetch geocode is finished")
                case .failure(let error):
                    print("ReceivingViewModel.calculateMapCoordinates() - ", error)
                }
            }, receiveValue: { [weak self] region in
                self?.selectedAddressRegion = region
            })
            .store(in: &cancellables)
    }
}
