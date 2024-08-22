//
//  ItemList.swift
//  Baobab
//
//  Created by 이정훈 on 7/25/24.
//

import SwiftUI

struct ItemList<T: ItemsViewModel>: View {
    @StateObject private var viewModel: T
    
    private let status: ItemStatus
    
    init(viewModel: T, status: ItemStatus) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.status = status
    }
    
    var body: some View {
        if viewModel.items?.isEmpty == true {
            EmptyItemView()
        } else if let items = viewModel.items {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        if status == .stored {
                            StoredItemDetailView(item: item, status: status)
                                .environmentObject(viewModel)
                        } else {
                            ItemDetailView(item: item, status: status)
                        }
                    } label: {
                        ItemInfoRow(item: item)
                            .padding([.top, .bottom])
                            .alignmentGuide(.listRowSeparatorLeading) { _ in return 0 }
                    }
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

#if DEBUG
#Preview {
    ItemList(viewModel: AppDI.shared.makeReceivingItemsViewModel(), status: .receiving)
}
#endif
