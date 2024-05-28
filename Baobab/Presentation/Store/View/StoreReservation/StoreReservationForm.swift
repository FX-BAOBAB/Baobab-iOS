//
//  StoreReservationForm.swift
//  Baobab
//
//  Created by 이정훈 on 5/20/24.
//

import SwiftUI

struct StoreReservationForm: View {
    @EnvironmentObject private var viewModel: StoreViewModel
    @State private var isShowingPostSearch: Bool = false
    @State private var isShowingAddressList: Bool = false
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    Section(header: SectionHeader(title: "날짜 선택"),
                            footer: SectionFooter()) {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(height: UIScreen.main.bounds.width)
                            .foregroundColor(.calendarGray)
                            .padding([.leading, .trailing, .bottom])
                            .overlay {
                                DatePicker("", selection: $viewModel.reservationDate, in: Date.tomorrow...)
                                    .datePickerStyle(.graphical)
                                    .padding([.leading, .trailing, .bottom], 30)
                            }
                    }
                    
                    Section(header: SectionHeader(title: "방문지 정보") {
                        Button(action:{ isShowingAddressList.toggle() },
                               label: { Text("변경").bold() })
                    }) {
                        SelectedAddressDetail()
                            .environmentObject(viewModel)
                            .padding([.leading, .trailing, .bottom])
                    }
                    
                    Color.white
                        .frame(height: UIScreen.main.bounds.width * 0.2)
                }
            }
            
            VStack {
                Spacer()
                
                Button(action: {}, label: {
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
            }
        }
        .navigationTitle("입고 예약")
        .onAppear {
            UIDatePicker.appearance().minuteInterval = 10    //선택 가능한 시간을 10분 단위로 설정
        }
        .sheet(isPresented: $isShowingAddressList) {
            AddressList(isShowingAddressList: $isShowingAddressList)
                .environmentObject(viewModel)
                .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    NavigationStack {
        StoreReservationForm()
            .environmentObject(AppDI.shared.storeViewModel)
    }
}
