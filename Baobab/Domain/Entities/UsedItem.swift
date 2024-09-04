//
//  UsedItem.swift
//  Baobab
//
//  Created by 이정훈 on 9/4/24.
//

import Foundation

struct UsedItem: Identifiable {
    let id: Int
    let title: String
    let price: Int
    let description, postedAt: String
    let item: Item
}

#if DEBUG
extension UsedItem {
    static var sampleData: [Self] {
        [
            UsedItem(id: 0,
                     title: "아이패드 판매합니다.",
                     price: 1000000,
                     description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                     postedAt: "2024-09-04T03:49:13.489Z",
                     item: Item.sampleData[0]),
            UsedItem(id: 1,
                     title: "아이패드 판매합니다.",
                     price: 0,
                     description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                     postedAt: "2024-09-04T03:49:13.489Z",
                     item: Item.sampleData[1])
        ]
    }
}
#endif
