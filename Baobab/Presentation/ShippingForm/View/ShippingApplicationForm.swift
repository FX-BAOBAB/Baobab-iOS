//
//  ShippingApplicationForm.swift
//  Baobab
//
//  Created by 이정훈 on 8/15/24.
//

import SwiftUI

struct ShippingApplicationForm: View {
    @ObservedObject private var viewModel: ShippingApplicationViewModel
    @Binding var isShowingShippingForm: Bool
    
    init(viewModel: ShippingApplicationViewModel, isShowingShippingForm: Binding<Bool>) {
        self.viewModel = viewModel
        _isShowingShippingForm = isShowingShippingForm
    }
    
    var body: some View {
        ZStack {
            Group {
                if viewModel.storedItems?.isEmpty == true {
                    EmptyItemView()
                } else if let storedItems = viewModel.storedItems {
                    List {
                        ForEach(storedItems) { item in
                            SelectableItemInfoRow(item: item)
                                .environmentObject(viewModel)
                                .alignmentGuide(.listRowSeparatorLeading) { _ in return 0 }
                        }
                    }
                    .listStyle(.plain)
                } else if viewModel.storedItems == nil {
                    ProgressView()
                        .onAppear {
                            if viewModel.storedItems == nil {
                                viewModel.fetchShippableItems()
                            }
                        }
                }
            }
            
            if viewModel.storedItems?.isEmpty == false {
                VStack(spacing: 0) {
                    Divider()
                    
                    Button {
                        
                    } label: {
                        Text("다음")
                            .bold()
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding(15)
                            .background(.accent)
                    }
                    .cornerRadius(10)
                    .padding()
                    .disabled(viewModel.selectedItems.isEmpty)
                }
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
        }
        .navigationTitle("출고하기")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    isShowingShippingForm.toggle()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundStyle(.black)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ShippingApplicationForm(viewModel: AppDI.shared.shippingFormViewModel,
                     isShowingShippingForm: .constant(true))
    }
}
