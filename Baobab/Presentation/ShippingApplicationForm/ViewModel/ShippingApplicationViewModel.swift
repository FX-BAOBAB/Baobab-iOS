//
//  ShippingFormViewModel.swift
//  Baobab
//
//  Created by 이정훈 on 8/15/24.
//

import MapKit
import Combine

final class ShippingApplicationViewModel: PostSearchable, Reservable {
    enum Result {
        case success
        case failure
    }
    
    @Published var defaultAddress: Address?
    @Published var searchedAddress: String = ""
    @Published var selectedAddressRegion: MKCoordinateRegion?
    @Published var searchedAddressRegion: MKCoordinateRegion?
    @Published var searchedPostCode: String = ""
    @Published var detailedAddressInput: String = ""
    @Published var reservationDate: Date = Date.tomorrow
    @Published var selectedAddress: Address?
    @Published var registeredAddresses: [Address] = []
    @Published var storedItems: [Item]?
    @Published var selectedItems: [Item] = [Item]()
    @Published var isShowingInvalidInputAlert: Bool = false
    @Published var isProgress: Bool = false
    @Published var result: Result?
    
    let shippingUseCase: ShippingUseCase
    let fetchItemUseCase: FetchItemUseCase
    var cancellables = Set<AnyCancellable>()
    
    init(shippingUseCase: ShippingUseCase, fetchItemUseCase: FetchItemUseCase) {
        self.shippingUseCase = shippingUseCase
        self.fetchItemUseCase = fetchItemUseCase
        
        calculateMapCoordinates()
    }
    
    func appendItem(_ item: Item) {
        selectedItems.append(item)
    }
    
    func removeItem(_ item: Item) {
        selectedItems = selectedItems.filter { $0 != item }
    }
    
    func applyShipping() {
        guard let selectedAddress else {
            isShowingInvalidInputAlert.toggle()
            return
        }
        
        isProgress.toggle()
        shippingUseCase.execute(deliveryDate: reservationDate, 
                        deliveryAddress: selectedAddress.address + " " + selectedAddress.detailAddress,
                        items: selectedItems)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isProgress.toggle()
                
                switch completion {
                case .finished:
                    print("The shipping application request has been completed")
                case .failure(let error):
                    print("ShippingApplicationViewModel.applyShipping() error :", error)
                    self?.result = .failure
                }
            }, receiveValue: { [weak self] in
                if $0 {
                    self?.result = .success
                } else {
                    self?.result = .failure
                }
            })
            .store(in: &cancellables)
    }
}
