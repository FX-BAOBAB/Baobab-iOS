//
//  ShippingApplicationViewModel+Items.swift
//  Baobab
//
//  Created by 이정훈 on 8/18/24.
//

import Foundation

extension ShippingApplicationViewModel {
    func fetchShippableItems() {
        usecase.fetchStoredItems()
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    print("Fetching the shippable items has been completed")
                case .failure(let error):
                    self?.storedItems = []
                    print("ShippingFormViewModel.fetchAvailableItemsForShipment() error : ", error)
                }
            }, receiveValue: { [weak self] in
                guard let items = $0 else {
                    self?.storedItems = []
                    return
                }
                
                self?.storedItems = items
            })
            .store(in: &cancellables)
    }
}
