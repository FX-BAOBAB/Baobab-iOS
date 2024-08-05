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
    private let type: FormType
    
    init(viewModel: T, title: String, type: FormType) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
        self.title = title
        self.type = type
    }
    
    var body: some View {
        if viewModel.isLoading != true {
            FormCollectionView<T>(formType: type)
                .environmentObject(viewModel)
                .navigationTitle(title)
                .navigationBarTitleDisplayMode(.inline)
                .edgesIgnoringSafeArea(.bottom)
                .onAppear {
                    if viewModel.forms == nil {
                        viewModel.fetchForms()
                    }
                }
        } else {
            ProgressView()
                .navigationTitle(title)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    NavigationStack {
        FormList(viewModel: AppDI.shared.receivingFormsViewModel, 
                 title: "입고 요청서",
                 type: .receivingForm)
    }
}
