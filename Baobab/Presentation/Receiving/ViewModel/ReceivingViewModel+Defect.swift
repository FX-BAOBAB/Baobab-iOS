//
//  ReceivingViewModel+Defect.swift
//  Baobab
//
//  Created by 이정훈 on 5/17/24.
//

import SwiftUI

//MARK: - Methods related to defect
extension ReceivingViewModel {
    func appendDefect() -> Bool {
        if let imageData = self.selectedDefectImage {
            items[itemIdx].defects.append(Defect(image: imageData, description: self.defectDescription))
            return true
        }
        
        return false
    }
    
    func removeDefect(at offsets: IndexSet) {
        items[itemIdx].defects.remove(atOffsets: offsets)
    }
}
