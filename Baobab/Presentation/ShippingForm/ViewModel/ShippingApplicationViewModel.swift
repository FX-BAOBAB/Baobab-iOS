//
//  ShippingFormViewModel.swift
//  Baobab
//
//  Created by 이정훈 on 8/15/24.
//

import Combine

final class ShippingApplicationViewModel: ObservableObject {
    @Published var storedItems: [Item]?
    @Published var selectedItems: [Item] = [Item]()
    
    private let usecase: ShippingUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(usecase: ShippingUseCase) {
        self.usecase = usecase
    }
    
    func appendItem(_ item: Item) {
        selectedItems.append(item)
    }
    
    func removeItem(_ item: Item) {
        selectedItems = selectedItems.filter { $0 != item }
    }
    
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
