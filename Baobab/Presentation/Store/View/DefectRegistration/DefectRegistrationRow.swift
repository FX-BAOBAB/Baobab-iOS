//
//  DefectRegistrationRow.swift
//  Baobab
//
//  Created by 이정훈 on 5/17/24.
//

import SwiftUI

struct DefectRegistrationRow: View {
    let defect: Defect
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Image(uiImage: defect.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width * 0.25)
                .cornerRadius(10)
            
            Text(defect.description)
                .font(.caption)
            
            Spacer()
        }
    }
}

#Preview {
    DefectRegistrationRow(defect: Defect(image: UIImage(), description: "결함 설명"))
}
