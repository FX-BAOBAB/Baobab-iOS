//
//  StoreBookingForm.swift
//  Baobab
//
//  Created by 이정훈 on 5/20/24.
//

import SwiftUI

struct StoreReservationForm: View {
    @EnvironmentObject private var viewModel: StoreViewModel
    @State private var isShowingAddressSelectionForm: Bool = false
    
    var body: some View {
        VStack {
            DatePicker("", selection: $viewModel.reservationDate, in: Date.tomorrow...)
                .datePickerStyle(.graphical)
                .padding([.leading, .trailing])
                .frame(width: UIScreen.main.bounds.width * 0.9)
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke()
                }
            
            Spacer()
            
            Button(action: {
                isShowingAddressSelectionForm.toggle()
            }, label: {
                Text("다음")
                    .bold()
                    .padding(8)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
            })
            .buttonBorderShape(.roundedRectangle)
            .cornerRadius(20)
            .buttonStyle(.borderedProminent)
            .padding(.top)
        }
        .padding()
        .navigationTitle("입고 예약")
        .onAppear {
            UIDatePicker.appearance().minuteInterval = 10    //선택 가능한 시간을 10분 단위로 설정
        }
    }
}

#Preview {
    NavigationStack {
        StoreReservationForm()
            .environmentObject(AppDI.shared.storeViewModel)
    }
}
