//
//  ItemList.swift
//  Baobab
//
//  Created by 이정훈 on 7/25/24.
//

import SwiftUI

struct ItemList<T: ItemsViewModel>: View {
    @ObservedObject private var viewModel: T
    
    init(viewModel: T) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        if let items = viewModel.items {
            List {
                ForEach(items) { item in
                    NavigationLink(destination: {
                        EmptyView()
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
    ItemList(viewModel: AppDI.shared.receivingItemsViewModel)
}
