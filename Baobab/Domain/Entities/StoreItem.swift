//
//  StoreItem.swift
//  Baobab
//
//  Created by 이정훈 on 5/26/24.
//

import Foundation

struct StoreItem {
    var itemName: String = ""
    var itemQuantity: Int = 1
    var itemCategoryWithPrice: String?
    var itemCategory: String?
    var itemPrice: Int?
    var itemImages: [Data?] = [nil, nil, nil, nil, nil, nil]
    var defects: [Defect] = []
}
