//
//  TransactionHistory.swift
//  Baobab
//
//  Created by 이정훈 on 9/11/24.
//

import Foundation

struct TransactionHistory {
    let usedGoodsOrderID: Int
    let buyer: UserInfo
    let seller: UserInfo
    let createdAt: String
    let usedGoodsID: Int
}

#if DEBUG
extension TransactionHistory {
    static var sampleData: Self {
        TransactionHistory(usedGoodsOrderID: 0,
                           buyer: UserInfo.sampleData,
                           seller: UserInfo.sampleData,
                           createdAt: "2024-09-06T19:33:40",
                           usedGoodsID: 0)
    }
}
#endif
