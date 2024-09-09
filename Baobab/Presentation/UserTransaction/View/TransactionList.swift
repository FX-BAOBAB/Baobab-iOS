//
//  TransactionList.swift
//  Baobab
//
//  Created by 이정훈 on 9/9/24.
//

import SwiftUI

struct TransactionList<T: TransactionViewModel>: View {
    @StateObject private var viewModel: T
    
    init(viewModel: T) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        if viewModel.usedItems?.isEmpty == true {
            EmptyItemView()
        } else if let usedItems = viewModel.usedItems {
            List {
                ForEach(usedItems) { usedItem in
                    NavigationLink {
                        TransactionItemDetail(usedItem: usedItem)
                    } label: {
                        ItemInfoRow(item: usedItem.item)
                    }
                    .padding([.top, .bottom])
                    .listRowSeparator(.hidden)
                }
            }
            .listStyle(.plain)
        } else {
            VStack {
                Spacer()
                
                ProgressView()
                
                Spacer()
            }
            .onAppear {
                if viewModel.usedItems == nil {
                    viewModel.fetchHistory()
                }
            }
        }
    }
}

#Preview {
    TransactionList(viewModel: AppDI.shared.makeUserPurchasedItemsViewModel())
}
