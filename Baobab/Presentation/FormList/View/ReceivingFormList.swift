//
//  ReceivingFormList.swift
//  Baobab
//
//  Created by 이정훈 on 8/13/24.
//

import SwiftUI

struct ReceivingFormList: View {
    @ObservedObject private var viewModel: ReceivingFormsViewModel
    
    init(viewModel: ReceivingFormsViewModel) {
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
                    ReceivingFormListRow(form: form)
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
    NavigationStack {
        ReceivingFormList(viewModel: AppDI.shared.receivingFormsViewModel)
    }
}
