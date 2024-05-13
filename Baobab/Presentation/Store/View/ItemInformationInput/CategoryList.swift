//
//  CategoryList.swift
//  Baobab
//
//  Created by 이정훈 on 5/13/24.
//

import SwiftUI

struct CategoryList: View {
    @EnvironmentObject private var viewModel: StoreViewModel
    
    var body: some View {
        List {
            ForEach(categories, id: \.self) { category in
                CategoryListRow(category: category,
                                isSelected: viewModel.itemCategoryWithPrice == category)
                .environmentObject(viewModel)
            }
        }
        .listStyle(.plain)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    CategoryList()
        .environmentObject(AppDI.shared.storeViewModel)
}
