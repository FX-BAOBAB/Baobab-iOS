//
//  ReceivingViewModel.swift
//  Baobab
//
//  Created by 이정훈 on 5/10/24.
//

import MapKit
import Combine
import Foundation

final class ReceivingViewModel: ObservableObject {
    @Published var items: [StoreItem] = [StoreItem(), StoreItem()]
    @Published var reservationDate: Date = Date.tomorrow
    @Published var selectedAddress: Address?
    @Published var defaultAddress: Address?    //TODO: 사용하지 않으면 삭제
    @Published var registeredAddresses: [Address]?
    @Published var selectedAddressRegion: MKCoordinateRegion?
    @Published var selectedDefectImage: Data?
    @Published var defectDescription: String = ""
    @Published var searchedAddress: String = ""
    @Published var searchedAddressRegion: MKCoordinateRegion?
    @Published var searchedPostCode: String = ""
    @Published var detailedAddressInput: String = ""
    
    var itemIdx: Int
    let usecase: ReceivingUseCase
    var cancellables = Set<AnyCancellable>()
    var totalPrice: Int {
        return (0..<itemIdx + 1).reduce(0, {
            $0 + (items[$1].itemPrice ?? 0)
        })
    }
    
    init(itemIdx: Int, usecase: ReceivingUseCase) {
        self.itemIdx = itemIdx
        self.usecase = usecase
        calculateMapCoordinates()
        
        #if DEBUG
        self.selectedAddress = Address.sampleAddressList.first
        self.defaultAddress = Address.sampleAddressList.first
        self.registeredAddresses = Address.sampleAddressList.filter { !($0.isBasicAddress) }
        #endif
    }
}

extension ReceivingViewModel {
    //MARK: - update itemCategory
    func addCategoryWithPrice(categoryWithPrice: String) {
        items[itemIdx].itemCategoryWithPrice = categoryWithPrice
        
        let firstIndex = categoryWithPrice.startIndex
        guard let lastIndex = categoryWithPrice.firstIndex(of: "[") else {
            return
        }
        
        let subString = categoryWithPrice[firstIndex..<lastIndex]
        items[itemIdx].itemCategory = String(subString).trimmingCharacters(in: .whitespacesAndNewlines)
        updatePrice()
    }
    
    func updatePrice() {
        items[itemIdx].itemCategoryWithPrice.map { categoryWithPrice in
            guard let firstIndex = categoryWithPrice.firstIndex(of: "["),
                  let lastIndex = categoryWithPrice.firstIndex(of: "원") else { return }
            
            let subString = categoryWithPrice[categoryWithPrice.index(firstIndex, offsetBy: 2)..<lastIndex]
            if let price = Int(subString) {
                items[itemIdx].itemPrice = price * items[itemIdx].itemQuantity
            }
        }
    }
}
