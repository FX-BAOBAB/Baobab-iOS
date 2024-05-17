//
//  StoreViewModel+Defect.swift
//  Baobab
//
//  Created by 이정훈 on 5/17/24.
//

import SwiftUI

//MARK: - Methods related to defect
extension StoreViewModel {    
    func appendDefect(image: UIImage, description: String) -> Bool {
        defects.append(Defect(image: image, description: description))
        return true
    }
    
    func removeDefect(at offsets: IndexSet) {
        defects.remove(atOffsets: offsets)
    }
}
