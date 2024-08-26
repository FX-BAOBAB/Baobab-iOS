//
//  LazyItemList.swift
//  Baobab
//
//  Created by 이정훈 on 8/26/24.
//

import SwiftUI

struct LazyItemList<T: ItemsViewModel>: View {
    @StateObject private var viewModel: T
    @Environment(\.dismiss) private var dismiss
    
    private let status: ItemStatus

    init(viewModel: T, status: ItemStatus) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.status = status
    }
    
    var body: some View {
        if status == .used {
            ItemList<T>(status: status)
                .environmentObject(viewModel)
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbarBackground(.white, for: .navigationBar)
                .navigationBarBackButtonHidden()
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.backward")
                        }
                    }
                }
        } else {
            ItemList<T>(status: status)
                .environmentObject(viewModel)
        }
    }
}

#Preview {
    LazyItemList(viewModel: AppDI.shared.makeReceivingItemsViewModel(), 
                 status: .receiving)
}
