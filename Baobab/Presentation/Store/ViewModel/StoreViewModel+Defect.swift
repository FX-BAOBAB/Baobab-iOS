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
        if let imageData = image.pngData() {
            items[itemIdx].defects.append(Defect(image: imageData, description: description))
            return true
        }
        
        return false
    }
    
    func removeDefect(at offsets: IndexSet) {
        items[itemIdx].defects.remove(atOffsets: offsets)
    }
}
