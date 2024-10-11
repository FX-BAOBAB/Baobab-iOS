//
//  ItemList.swift
//  Baobab
//
//  Created by 이정훈 on 7/25/24.
//

import SwiftUI

struct ItemList<T: ItemsViewModel>: View {
    @EnvironmentObject private var viewModel: T
    
    let status: ItemStatus
    
    var body: some View {
        if viewModel.items?.isEmpty == true {
            EmptyItemView()
        } else if let items = viewModel.items {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        if status == .stored {
                            StoredItemDetailView(itemImageViewModel: AppDI.shared.makeItemImageViewModel(), item: item)
                                .environmentObject(viewModel)
                        } else {
                            ItemDetailView(viewModel: AppDI.shared.makeItemStatusConversionViewModel(),
                                           itemViewModel: AppDI.shared.makeItemImageViewModel(),
                                           item: item)
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
            .onReceive(NotificationCenter.default.publisher(for: .itemstatusConversionComplete)) {
                if let result = $0.userInfo?["isCompleted"] as? Bool, result {
                    viewModel.fetchItems()
                }
            }
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
    ItemList<ReceivingItemsViewModel>(status: .receiving)
        .environmentObject(AppDI.shared.makeReceivingItemsViewModel())
}
#endif
