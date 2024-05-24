//
//  StoreViewModel.swift
//  Baobab
//
//  Created by 이정훈 on 5/10/24.
//

import Combine
import Foundation

final class StoreViewModel: ObservableObject {
    @Published var itemName: String = ""
    @Published var itemQuantity: Int = 1
    @Published var itemCategoryWithPrice: String? = nil
    @Published var itemCategory: String? = nil
    @Published var itemPrice: Int? = nil
    @Published var itemImages: [Data?] = [nil, nil, nil, nil, nil, nil]    //index: 0(정면), 1(후면), 2(배면), 3(밑면), 4(좌), 5(우)
    @Published var defects: [Defect] = []
    @Published var reservationDate: Date = Date.tomorrow
    @Published var address: String = "서울특별시 성동구 독서당로 377"
    @Published var detailAddress: String = "○○○동 ○○○호 (응봉동, 금호현대아파트)"
    @Published var postCode: String = "12345"
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        updatePrice()
        updateCategoryName()
    }
}

//MARK: - Subscribe
extension StoreViewModel {
    //MARK: - update itemCategory
    private func updateCategoryName() {
        $itemCategoryWithPrice
            .dropFirst(1)
            .sink { [weak self] category in
                category.map { value in
                    let firstIndex = value.startIndex
                    guard let lastIndex = value.firstIndex(of: "[") else {
                        return
                    }
                    
                    let subString = value[firstIndex..<lastIndex]
                    self?.itemCategory = String(subString).trimmingCharacters(in: .whitespacesAndNewlines)
                }
            }
            .store(in: &cancellables)
    }
    
    //MARK: - update itemPrice
    private func updatePrice() {
        let publisher = $itemCategoryWithPrice.combineLatest($itemQuantity)
        publisher
            .dropFirst(1)
            .sink { [weak self] category, quantity in
                category.map { categoryValue in
                    guard let firstIndex = categoryValue.firstIndex(of: "["), let lastIndex = categoryValue.firstIndex(of: "원") else {
                        return
                    }
                    
                    let subString = categoryValue[categoryValue.index(firstIndex, offsetBy: 2)..<lastIndex]
                    Int(subString).map {
                        self?.itemPrice = $0 * quantity
                    }
                }
            }
            .store(in: &cancellables)
    }
}
