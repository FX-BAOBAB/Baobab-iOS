//
//  ReturnFormList.swift
//  Baobab
//
//  Created by 이정훈 on 8/14/24.
//

import SwiftUI

struct ReturnFormList: View {
    @ObservedObject private var viewModel: ReturnFormsViewModel
    
    init(viewModel: ReturnFormsViewModel) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        if viewModel.forms?.isEmpty == true {
            NoFormDataView()
                .navigationTitle("입고 요청서")
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbarBackground(.white, for: .navigationBar)
        } else if let forms = viewModel.forms {
            List {
                ForEach(forms) { form in
                    ReturnFormListRow(form: form)
                        .padding([.top, .bottom])
                        .listRowSeparator(.hidden)
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .background(.listFooterGray)
            .navigationTitle("입고 요청서")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(.white, for: .navigationBar)
        } else {
            ProgressView()
                .navigationTitle("입고 요청서")
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbarBackground(.white, for: .navigationBar)
                .onAppear {
                    viewModel.fetchForms()
                }
        }
    }
}

#Preview {
    ReturnFormList(viewModel: AppDI.shared.returnFormsViewModel)
}
