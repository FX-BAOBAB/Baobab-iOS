//
//  ShippingApplicationForm.swift
//  Baobab
//
//  Created by 이정훈 on 8/15/24.
//

import SwiftUI

struct ShippingApplicationForm: View {
    @StateObject private var viewModel: ShippingApplicationViewModel
    @State private var isShowingReservationForm: Bool = false
    @Binding var isShowingFullScreenCover: Bool
    
    init(viewModel: ShippingApplicationViewModel, isShowingShippingForm: Binding<Bool>) {
        _viewModel = StateObject(wrappedValue: viewModel)
        _isShowingFullScreenCover = isShowingShippingForm
    }
    
    var body: some View {
        Group {
            if viewModel.storedItems?.isEmpty == true {
                EmptyItemView()
            } else if let storedItems = viewModel.storedItems {
                VStack(spacing: 0) {
                    List {
                        ForEach(storedItems) { item in
                            SelectableItemInfoRow(item: item)
                                .environmentObject(viewModel)
                                .alignmentGuide(.listRowSeparatorLeading) { _ in return 0 }
                        }
                    }
                    .listStyle(.plain)
                    
                    if viewModel.storedItems?.isEmpty == false {
                        VStack(spacing: 0) {
                            Divider()
                            
                            Button {
                                isShowingReservationForm.toggle()
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
            } else if viewModel.storedItems == nil {
                ProgressView()
            }
        }
        .onAppear {
            if viewModel.storedItems == nil {
                viewModel.fetchShippableItems()
            }
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
        .navigationDestination(isPresented: $isShowingReservationForm) {
            ReservationForm<ShippingApplicationViewModel, _>(
                isShowingFullScreenCover: $isShowingFullScreenCover,
                nextView: ShippingApplicationCompletionView(isShowingFullScreenCover: $isShowingFullScreenCover).environmentObject(viewModel),
                calendarCaption: "선택한 날짜에 맞춰 물품이 배송될 예정이에요.",
                addressHeader: "배송지 선택",
                navigationHeader: "출고 예약"
            )
            .environmentObject(viewModel)
        }
    }
}

#Preview {
    NavigationStack {
        ShippingApplicationForm(viewModel: AppDI.shared.makeShippingApplicationViewModel(),
                     isShowingShippingForm: .constant(true))
    }
}
