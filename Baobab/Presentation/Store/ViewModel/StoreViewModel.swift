//
//  StoreViewModel.swift
//  Baobab
//
//  Created by 이정훈 on 5/10/24.
//

import Combine
import MapKit
import Foundation

final class StoreViewModel: ObservableObject {
    @Published var items: [StoreItem] = [StoreItem(), StoreItem()]
    @Published var reservationDate: Date = Date.tomorrow
    @Published var selectedAddress: Address?
    @Published var defaultAddress: Address?
    @Published var registeredAddresses: [Address]?
    @Published var region: MKCoordinateRegion?
    
    var itemIdx: Int
    private var cancellables = Set<AnyCancellable>()
    
    init(itemIdx: Int) {
        self.itemIdx = itemIdx
        
        #if DEBUG
        self.selectedAddress = Address.sampleAddressList.first
        self.defaultAddress = Address.sampleAddressList.first
        self.registeredAddresses = Address.sampleAddressList.filter { !($0.isBasicAddress) }
        #endif
    }
}

extension StoreViewModel {
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
