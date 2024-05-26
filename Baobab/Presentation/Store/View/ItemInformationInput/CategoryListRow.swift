//
//  CategoryListRow.swift
//  Baobab
//
//  Created by 이정훈 on 5/13/24.
//

import SwiftUI

struct CategoryListRow: View {
    @EnvironmentObject private var viewModel: StoreViewModel
    
    let category: String
    let isSelected: Bool
    
    var body: some View {
        Button(action: {
            viewModel.addCategoryWithPrice(categoryWithPrice: category)
        }, label: {
            HStack {
                Text(category)
                    .foregroundColor(.black)
                
                Spacer()
                
                if isSelected {
                    CheckMark()
                }
            }
            .padding([.top, .bottom])
        })
    }
}

#Preview {
    CategoryListRow(category: "전자기기", isSelected: true)
        .environmentObject(AppDI.shared.storeViewModel)
}
