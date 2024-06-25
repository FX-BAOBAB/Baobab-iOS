//
//  ReceivingViewModel+Region.swift
//  Baobab
//
//  Created by 이정훈 on 5/28/24.
//

import MapKit

extension ReceivingViewModel {
    func showLocationOnMap() {
        usecase.fetchGeoCode(of: self.searchedAddress)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Request to fetch geocode successful")
                case .failure(let error):
                    print("ReceivingViewModel.showLocationOnMap(_:) - ", error)
                }
            }, receiveValue: { [weak self] region in
                self?.region = region
            })
            .store(in: &cancellables)
    }
}
