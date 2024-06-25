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
    @Published var defaultAddress: Address?
    @Published var registeredAddresses: [Address]?
    @Published var region: MKCoordinateRegion?
    @Published var selectedDefectImage: Data?
    @Published var defectDescription: String = ""
    @Published var searchedAddress: String = ""
    @Published var searchedPostCode: String = ""
    @Published var detailedAddressInput: String = ""
    
    var itemIdx: Int
    let usecase: ReceivingUseCase
    var cancellables = Set<AnyCancellable>()
    
    init(itemIdx: Int, usecase: ReceivingUseCase) {
        self.itemIdx = itemIdx
        self.usecase = usecase
        
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
    
    func calculateTotalPrice() -> Int {
        var totalPrice: Int = 0
        
        for i in 0..<itemIdx + 1 {
            items[i].itemPrice.map { price in
                totalPrice += price
            }
        }
        
        return totalPrice
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
