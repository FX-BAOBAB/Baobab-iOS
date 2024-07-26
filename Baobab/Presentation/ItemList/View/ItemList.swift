//
//  ItemList.swift
//  Baobab
//
//  Created by 이정훈 on 7/25/24.
//

import SwiftUI

struct ItemList<T: ItemsViewModel>: View {
    @ObservedObject private var viewModel: T
    
    private let status: ItemStatus
    
    init(viewModel: T, status: ItemStatus) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
        self.status = status
    }
    
    var body: some View {
        if let items = viewModel.items {
            List {
                ForEach(items) { item in
                    NavigationLink(destination: {
                        DetailedItemView(item: item, status: status)
                    }) {
                        ItemInfoRow(item: item)
                    }
                }
            }
        } else {
            VStack {
                Spacer()
                
                ProgressView()
                
                Spacer()
            }
            .onAppear {
                viewModel.fetchItems()
            }
        }
    }
}

#Preview {
    ItemList(viewModel: AppDI.shared.receivingItemsViewModel, status: .receiving)
}
