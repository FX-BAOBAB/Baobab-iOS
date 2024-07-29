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
        
        var layoutConfig = UICollectionLayoutListConfiguration(appearance: .grouped)
        layoutConfig.headerMode = .supplementary
        layoutConfig.footerMode = .none
        layoutConfig.backgroundColor = .listFooterGray
        layoutConfig.showsSeparators = false
        
        let listLayout = UICollectionViewCompositionalLayout.list(using: layoutConfig)
        UICollectionView.appearance().collectionViewLayout = listLayout
    }
    
    var body: some View {
        Group {
            if let forms = viewModel.forms {
                List {
                    ForEach(forms) { form in
                        Section {
                            FormListRow(form: form)
                                .padding([.top, .bottom])
                        }
                    }
                }
                .listStyle(.inset)
                .toolbarBackground(.white, for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
            } else {
                ProgressView()
                    .onAppear {
                        viewModel.forms = FormData.sampleData
                    }
            }
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        FormList(viewModel: AppDI.shared.receivingFormsViewModel, title: "입고 요청서")
    }
}
