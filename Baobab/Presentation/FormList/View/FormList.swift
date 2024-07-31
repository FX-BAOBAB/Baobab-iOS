//
//  FormList.swift
//  Baobab
//
//  Created by 이정훈 on 7/26/24.
//

import SwiftUI

struct FormList<T: FormsViewModel>: View {
    @ObservedObject private var viewModel: T
    
    private let title: String
    
    init(viewModel: T, title: String) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
        self.title = title
    }
    
    var body: some View {
        FormCollectionView<T>()
            .environmentObject(viewModel)
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .edgesIgnoringSafeArea(.bottom)
            .onAppear {
                if viewModel.forms == nil {
                    viewModel.forms = FormData.sampleData
                }
            }
    }
}

#Preview {
    NavigationStack {
        FormList(viewModel: AppDI.shared.receivingFormsViewModel, title: "입고 요청서")
    }
}
