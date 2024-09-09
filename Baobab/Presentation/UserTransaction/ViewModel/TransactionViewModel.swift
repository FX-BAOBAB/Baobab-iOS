//
//  TransactionViewModel.swift
//  Baobab
//
//  Created by 이정훈 on 9/9/24.
//

import Foundation

protocol TransactionViewModel: ObservableObject {
    var usedItems: [UsedItem]? { get set }
    
    func fetchHistory()
}
