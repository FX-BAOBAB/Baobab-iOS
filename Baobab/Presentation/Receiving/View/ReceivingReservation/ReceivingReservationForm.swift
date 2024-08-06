//
//  ReceivingReservationForm.swift
//  Baobab
//
//  Created by 이정훈 on 5/20/24.
//

import SwiftUI

struct ReceivingReservationForm: View {
    @EnvironmentObject private var viewModel: ReceivingViewModel
    @State private var isShowingPostSearch: Bool = false
    @State private var isShowingAddressList: Bool = false
    @State private var isShowingPaymentView: Bool = false
    @Binding var isShowingReceivingForm: Bool
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    Section(header: SectionHeader(title: "방문 날짜 선택"),
                            footer: SectionFooter()) {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(height: UIScreen.main.bounds.width)
                            .foregroundColor(Color(red: 241 / 255, green: 243 / 255, blue: 245 / 255))
                            .padding([.leading, .trailing, .bottom])
                            .overlay {
                                DatePicker("", selection: $viewModel.reservationDate, in: Date.tomorrow...)
                                    .datePickerStyle(.graphical)
                                    .padding([.leading, .trailing, .bottom], 30)
                            }
                    }
                    
                    Section(header: SectionHeader(title: "방문지 선택")) {
                        SelectedAddressDetail(showTag: true)
                            .environmentObject(viewModel)
                            .padding([.leading, .trailing, .bottom])
                        
                        Button {
                            isShowingAddressList.toggle()
                        } label: {
                            EditButtonLabel()
                        }
                        .padding(.top)
                    }
                    
                    Color.white
                        .frame(height: UIScreen.main.bounds.width * 0.3)
                }
            }
            
            Button(action: {
                isShowingPaymentView.toggle()
            }, label: {
                Text("다음")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding(8)
            })
            .buttonBorderShape(.roundedRectangle)
            .cornerRadius(10)
            .buttonStyle(.borderedProminent)
            .padding([.leading, .trailing, .bottom])
            .background(.white)
            .frame(maxHeight: .infinity, alignment: .bottom)
        }
        .navigationTitle("입고 예약")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            UIDatePicker.appearance().minuteInterval = 10    //선택 가능한 시간을 10분 단위로 설정
            
            viewModel.fetchDefaultAddress()    //기본 주소 요청
        }
        .sheet(isPresented: $isShowingAddressList) {
            AddressList(isShowingAddressList: $isShowingAddressList)
                .environmentObject(viewModel)
                .presentationDragIndicator(.visible)
        }
        .navigationDestination(isPresented: $isShowingPaymentView) {
            ReceivingPaymentView(isShowingReceivingForm: $isShowingReceivingForm)
                .environmentObject(viewModel)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    isShowingReceivingForm.toggle()
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
        ReceivingReservationForm(isShowingReceivingForm: .constant(true))
            .environmentObject(AppDI.shared.receivingViewModel)
    }
}
