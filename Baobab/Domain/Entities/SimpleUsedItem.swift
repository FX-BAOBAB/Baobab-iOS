//
//  SimpleUsedItem.swift
//  Baobab
//
//  Created by 이정훈 on 9/20/24.
//

import Foundation

struct SimpleUsedItem: Identifiable {
    let id: Int
    let title: String
    let price: Int
    let postedAt: String
    let item: Item
}

#if DEBUG
extension SimpleUsedItem {
    static var sampleData: Self {
        SimpleUsedItem(id: 0,
                       title: "테스트",
                       price: 10000,
                       postedAt: "2024-09-04T03:49:13.489Z",
                       item: Item.sampleData[0])
    }
}
#endif
