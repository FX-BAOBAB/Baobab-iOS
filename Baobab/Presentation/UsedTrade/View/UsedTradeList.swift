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
        List {
            if let items = viewModel.items {
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
        }
        .listStyle(.plain)
        .refreshable {
            
        }
        .onAppear {
            viewModel.items = UsedItem.sampleData
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Text("중고장터")
                    .bold()
                    .font(.title3)
            }
        }
    }
}

#Preview {
    NavigationStack {
        UsedTradeList(viewModel: AppDI.shared.makeUsedTradeViewModel())
    }
}
