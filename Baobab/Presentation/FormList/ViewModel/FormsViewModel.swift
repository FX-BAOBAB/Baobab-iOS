//
//  FormsViewModel.swift
//  Baobab
//
//  Created by 이정훈 on 7/26/24.
//

import Combine

protocol FormsViewModel: AnyObject, ObservableObject {
    associatedtype T
    
    var forms: [T]? { get set }
    var isLoading: Bool { get set }
    
    func fetchForms()
}
