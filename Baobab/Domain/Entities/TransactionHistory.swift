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
