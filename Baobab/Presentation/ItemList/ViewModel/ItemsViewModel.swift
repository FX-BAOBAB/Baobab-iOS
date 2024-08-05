//
//  ItemsViewModel.swift
//  Baobab
//
//  Created by 이정훈 on 7/25/24.
//

import Combine

protocol ItemsViewModel: AnyObject, ObservableObject {
    var items: [Item]? { get set }
    
    func fetchItems()
}
