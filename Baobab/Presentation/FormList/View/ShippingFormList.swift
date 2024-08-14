//
//  ShippingFormList.swift
//  Baobab
//
//  Created by 이정훈 on 8/14/24.
//

import SwiftUI

struct ShippingFormList: View {
    @ObservedObject private var viewModel: ShippingFormsViewModel
    
    init(viewModel: ShippingFormsViewModel) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        Group {
            if viewModel.forms?.isEmpty == true {
                NoFormDataView()
            } else if let forms = viewModel.forms {
                List {
                    ForEach(forms) { form in
                        VStack {
                            ShippingFormListRow(form: form)
                            
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
    }
}

#Preview {
    ShippingFormList(viewModel: AppDI.shared.shippingFormsViewModel)
}
