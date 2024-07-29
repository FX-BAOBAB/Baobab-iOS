//
//  FormsViewModel.swift
//  Baobab
//
//  Created by 이정훈 on 7/26/24.
//

import Combine

protocol FormsViewModel: AnyObject, ObservableObject {
    var forms: [FormData]? { get set }
    
    func fetchForms()
}
