//
//  UsedTradeList.swift
//  Baobab
//
//  Created by 이정훈 on 8/5/24.
//

import SwiftUI

struct UsedTradeList: View {
    @StateObject private var viewModel: UsedTradeViewModel
    
    init(viewModel: UsedTradeViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        if viewModel.items?.isEmpty == true {
            EmptyItemView()
        } else if let items = viewModel.items {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        UsedTradeDetail(usedItem: item)
                    } label: {
                        UsedTradeListRow(usedItem: item)
                            .padding([.top, .bottom], 10)
                    }
                    .listRowSeparator(.hidden)
                }
            }
            .listStyle(.plain)
            .refreshable {
                await viewModel.fetchUsedItems()
            }
        } else {
            UsedTradeSkeletonList()
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
        UsedTradeList(viewModel: AppDI.shared.makeUsedTradeViewModel())
    }
}
