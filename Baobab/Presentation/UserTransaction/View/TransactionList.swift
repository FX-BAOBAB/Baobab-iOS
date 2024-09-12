//
//  TransactionList.swift
//  Baobab
//
//  Created by 이정훈 on 9/9/24.
//

import SwiftUI

struct TransactionList<T: TransactionViewModel>: View {
    enum RowType {
        case transactionHistory
        case itemDetailOnly
    }
    
    @StateObject private var viewModel: T
    @State private var isShowingItemDetail: Bool = false
    @State private var selectedItem: UsedItem?
    
    let rowType: RowType
    
    init(viewModel: T, rowType: RowType = .itemDetailOnly) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.rowType = rowType
    }
    
    var body: some View {
        if viewModel.usedItems?.isEmpty == true {
            EmptyItemView()
        } else if let usedItems = viewModel.usedItems {
            List {
                ForEach(usedItems) { usedItem in
                    Group {
                        switch rowType {
                        case .transactionHistory:
                            SoldItemListRow(selectedItem: $selectedItem,
                                            isShowingItemDetail: $isShowingItemDetail,
                                            usedItem: usedItem)
                        case .itemDetailOnly:
                            SaleItemListRow(selectedItem: $selectedItem,
                                            isShowingItemDetail: $isShowingItemDetail,
                                            usedItem: usedItem)
                        }
                    }
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .background(.listFooterGray)
            .navigationDestination(isPresented: $isShowingItemDetail) {
                if let usedItem = selectedItem {
                    TransactionItemDetail(usedItem: usedItem)
                }
            }
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
