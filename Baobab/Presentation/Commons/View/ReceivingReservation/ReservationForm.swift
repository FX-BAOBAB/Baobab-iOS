//
//  ReceivingReservationForm.swift
//  Baobab
//
//  Created by 이정훈 on 5/20/24.
//

import SwiftUI

struct ReservationForm<T: PostSearchable, V: View>: View where T: Reservable {
    @EnvironmentObject private var viewModel: T
    @Environment(\.dismiss) private var dismiss
    @State private var isShowingPostSearch: Bool = false
    @State private var isShowingAddressList: Bool = false
    @Binding var isShowingFullScreenCover: Bool
    
    let nextView: V
    let calendarCaption: String
    let addressHeader: String
    let navigationHeader: String
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                Section(footer: SectionFooter()) {
                    DatePicker("", selection: $viewModel.reservationDate, in: Date.tomorrow...)
                        .datePickerStyle(.graphical)
                        .padding([.leading, .trailing])
                    
                    HStack(spacing: 5) {
                        Image(systemName: "info.circle")
                        
                        Text(calendarCaption)
                        
                        Spacer()
                    }
                    .font(.caption2)
                    .padding()
                    .foregroundStyle(.gray)
                }
                
                Section(header: SectionHeader(title: addressHeader)) {
                    SelectedAddressDetail<T>(showTag: true)
                        .environmentObject(viewModel)
                        .padding([.leading, .trailing, .bottom])
                    
                    Button {
                        isShowingAddressList.toggle()
                    } label: {
                        EditButtonLabel()
                    }
                    .padding(.top)
                }
                
                Color.clear
                    .frame(height: UIScreen.main.bounds.width * 0.1)
            }
            
            VStack(spacing: 0) {
                Divider()
                    .foregroundStyle(.red)
                
                NavigationLink {
                    nextView
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
            }
            .background(.white)
        }
        .navigationTitle(navigationHeader)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            UIDatePicker.appearance().minuteInterval = 10    //선택 가능한 시간을 10분 단위로 설정
            
            viewModel.fetchDefaultAddress()    //기본 주소 요청
        }
        .sheet(isPresented: $isShowingAddressList) {
            AddressList<T>(isShowingAddressList: $isShowingAddressList, toggleVisible: true) {
                viewModel.registerAsSelectedAddress()
                isShowingAddressList.toggle()
            }
            .environmentObject(viewModel)
            .presentationDragIndicator(.visible)
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    isShowingFullScreenCover.toggle()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundStyle(.black)
                }
            }
            
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
        ReservationForm<ReceivingViewModel, _>(
            isShowingFullScreenCover: .constant(true),
            nextView: EmptyView(),
            calendarCaption: "선택한 시간에 아래 방문지를 통해 입고 물품을 수령할 예정이에요.", 
            addressHeader: "방문지 선택",
            navigationHeader: "입고예약"
        )
        .environmentObject(AppDI.shared.makeReceivingViewModel())
    }
}
