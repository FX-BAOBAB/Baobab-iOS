//
//  ReceivingFormList.swift
//  Baobab
//
//  Created by 이정훈 on 8/13/24.
//

import SwiftUI

struct ReceivingFormList: View {
    @ObservedObject private var viewModel: ReceivingFormsViewModel
    @Environment(\.dismiss) private var dismiss
    
    init(viewModel: ReceivingFormsViewModel) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        Group {
            if viewModel.forms?.isEmpty == true {
                NoFormDataView()
            } else if let forms = viewModel.forms {
                List {
                    ForEach(forms) { form in
                        VStack(spacing: 0) {
                            ReceivingFormListRow(form: form)
                            
                            SectionFooter()
                        }
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .listRowSeparator(.hidden)
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .background(.listFooterGray)
            } else {
                ProgressView()
                    .onAppear {
                        viewModel.fetchForms()
                    }
            }
        }
        .navigationTitle("입고 요청서")
        .navigationBarTitleDisplayMode(.inline)
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
    }
}

#Preview {
    NavigationStack {
        ReceivingFormList(viewModel: AppDI.shared.makeReceivingFormsViewModel())
    }
}
