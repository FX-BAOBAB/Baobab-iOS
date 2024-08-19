//
//  ShippingApplicationForm.swift
//  Baobab
//
//  Created by 이정훈 on 8/15/24.
//

import SwiftUI

struct ShippingApplicationForm: View {
    @ObservedObject private var viewModel: ShippingApplicationViewModel
    @Binding var isShowingFullScreenCover: Bool
    
    init(viewModel: ShippingApplicationViewModel, isShowingShippingForm: Binding<Bool>) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
        _isShowingFullScreenCover = isShowingShippingForm
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
//                        .onAppear {
//                            if viewModel.storedItems == nil {
//                                viewModel.fetchShippableItems()
//                            }
//                        }
                }
            }
            
            if viewModel.storedItems?.isEmpty == false {
                VStack(spacing: 0) {
                    Divider()
                    
                    NavigationLink {
                        ReservationForm<ShippingApplicationViewModel, _>(
                            isShowingFullScreenCover: $isShowingFullScreenCover,
                            nextView: ShippingApplicationCompletionView(isShowingFullScreenCover: $isShowingFullScreenCover).environmentObject(viewModel),
                            calendarCaption: "선택한 날짜에 맞춰 물품이 배송될 예정이에요.", 
                            addressHeader: "배송지 선택"
                        )
                        .environmentObject(viewModel)
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
        .onAppear {
            if viewModel.storedItems == nil {
                viewModel.fetchShippableItems()
            }
        }
        .onDisappear {
            viewModel.storedItems = nil
            viewModel.selectedItems = []
        }
        .navigationTitle("출고하기")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    isShowingFullScreenCover.toggle()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundStyle(.black)
                }
            }
        }
        .alert(isPresented: $viewModel.isShowingInvalidInputAlert) {
            Alert(title: Text("알림"), message: Text("정확한 날짜와 주소를 입력해 주세요."))
        }
    }
}

#Preview {
    NavigationStack {
        ShippingApplicationForm(viewModel: AppDI.shared.shippingApplicationViewModel,
                     isShowingShippingForm: .constant(true))
    }
}
