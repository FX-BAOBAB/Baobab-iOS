//
//  ShippingFormViewModel.swift
//  Baobab
//
//  Created by 이정훈 on 8/15/24.
//

import MapKit
import Combine

final class ShippingApplicationViewModel: PostSearchable, Reservable {
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
    
    let usecase: ShippingUseCase
    var cancellables = Set<AnyCancellable>()
    
    init(usecase: ShippingUseCase) {
        self.usecase = usecase
        
        calculateMapCoordinates()
    }
    
    func appendItem(_ item: Item) {
        selectedItems.append(item)
    }
    
    func removeItem(_ item: Item) {
        selectedItems = selectedItems.filter { $0 != item }
    }
}
