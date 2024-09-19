//
//  UsedItemList.swift
//  Baobab
//
//  Created by 이정훈 on 8/5/24.
//

import SwiftUI

struct UsedItemList: View {
    @StateObject private var viewModel: UsedItemListViewModel
    
    init(viewModel: UsedItemListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        if viewModel.items?.isEmpty == true {
            EmptyItemView()
        } else if let items = viewModel.items {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        UsedItemDetail(viewModel: AppDI.shared.makeUsedItemViewModel(),
                                        usedItem: item)
                    } label: {
                        UsedItemListRow(usedItem: item)
                            .padding([.top, .bottom], 10)
                    }
                    .listRowSeparator(.hidden)
                    .onAppear {
                        if case .some(let value) = viewModel.items?.count,
                           value > 9 && item.id == viewModel.items?.last?.id,
                           !viewModel.isLoading {
                            Task {
                                await viewModel.fetchNextUsedItems()
                            }
                        }
                    }
                }
                
                HStack {
                    Spacer()
                    
                    if viewModel.isLoading {
                        ProgressView()
                    }
                    
                    Text(" ")
                    
                    Spacer()
                }
                .listRowSeparator(.hidden)
                .padding()
            }
            .listStyle(.plain)
            .refreshable {
                await viewModel.fetchUsedItems()
            }
        } else {
            UsedItemSkeletonList()
                .task {
                    if viewModel.items == nil {
                        await viewModel.fetchUsedItems()
                    }
                }
        }
    }
}

#Preview {
    NavigationStack {
        UsedItemList(viewModel: AppDI.shared.makeUsedTradeViewModel())
    }
}
