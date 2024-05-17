//
//  StoreViewModel.swift
//  Baobab
//
//  Created by 이정훈 on 5/10/24.
//

import Combine
import SwiftUI

final class StoreViewModel: ObservableObject {
    @Published var itemName: String = ""
    @Published var itemQuantity: Int = 1
    @Published var itemCategoryWithPrice: String? = nil
    @Published var itemCategory: String? = nil
    @Published var price: Int? = nil
    @Published var itemImages: [UIImage?] = [nil, nil, nil, nil, nil, nil]    //index: 0(정면), 1(후면), 2(배면), 3(밑면), 4(좌), 5(우)
    @Published var defects: [Defect] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        updateCategoryName()
        updatePrice()
    }
}

//MARK: - Subscribe
extension StoreViewModel {
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
                        self?.price = $0 * quantity
                    }
                }
            }
            .store(in: &cancellables)
    }
}
