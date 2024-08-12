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
        if viewModel.items?.isEmpty == true {
            EmptyItemView()
                .onAppear {
                    print("init EmptyItem View")
                }
        } else if let items = viewModel.items {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        DetailedItemView(item: item, status: status)
                    } label: {
                        ItemInfoRow(item: item)
                            .padding([.top, .bottom])
                    }
                    .listRowSeparator(.hidden)
                }
            }
            .listStyle(.plain)
            .background(.listFooterGray)
            .scrollContentBackground(.hidden)
        } else if viewModel.items == nil {
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
