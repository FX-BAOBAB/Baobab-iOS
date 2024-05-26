//
//  StoreViewModel.swift
//  Baobab
//
//  Created by 이정훈 on 5/10/24.
//

import Combine
import Foundation

final class StoreViewModel: ObservableObject {
    @Published var items: [StoreItem] = [StoreItem(), StoreItem()]
    @Published var reservationDate: Date = Date.tomorrow
    @Published var address: String = "서울특별시 성동구 독서당로 377"
    @Published var detailAddress: String = "○○○동 ○○○호 (응봉동, 금호현대아파트)"
    @Published var postCode: String = "12345"
    
    var itemIdx: Int
    private var cancellables = Set<AnyCancellable>()
    
    init(itemIdx: Int) {
        self.itemIdx = itemIdx
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
