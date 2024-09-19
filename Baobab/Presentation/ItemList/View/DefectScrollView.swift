//
//  DefectScrollView.swift
//  Baobab
//
//  Created by 이정훈 on 9/18/24.
//

import SwiftUI

struct DefectScrollView: View {
    @Binding var defectData: [(image: Data, caption: String)]?
    
    let defectCount: Int
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            if let defectData = defectData {
                HStack {
                    ForEach(0..<defectData.count, id: \.self) { idx in
                        DefectRow(imageData: defectData[idx].image, caption: defectData[idx].caption)
                    }
                }
                .padding(.leading)
            } else {
                HStack {
                    ForEach(0..<defectCount, id: \.self) { _ in
                        Color.clear
                            .skeleton(with: true,
                                      size: CGSize(width: UIScreen.main.bounds.width * 0.5,
                                                   height: UIScreen.main.bounds.width * 0.5 + 60),
                                      shape: .rectangle)
                            .cornerRadius(10)
                            .shadow(radius: 6)
                            .padding()
                    }
                }
                .padding(.leading)
            }
            
        }
    }
}

#Preview {
    DefectScrollView(defectData: .constant(nil), defectCount: 3)
}
