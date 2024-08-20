//
//  ImageRegistrationCompleteSheet.swift
//  Baobab
//
//  Created by 이정훈 on 5/26/24.
//

import SwiftUI

struct ImageRegistrationCompleteSheet: View {
    @EnvironmentObject private var viewModel: ReceivingViewModel
    @Binding var isShowingReservationForm: Bool
    @Binding var isShowingNewItemAdditionSheet: Bool
    @Binding var isShowingDefectRegistrationList: Bool
    @Binding var isShowingImageRegistrationCompleteSheet: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("사진 등록을 완료했어요!")
                .font(.title2)
                .bold()
                .padding(.top)
            
            Text("물품의 결함 사진을 추가할 수 있어요")
                .padding(.bottom)
            
            HStack(alignment: .top, spacing: 3) {
                Image(systemName: "info.circle")
                
                VStack(alignment: .leading) {
                    Text("물품 결함을 등록하지 않을시 Baobab에서는")
                    
                    Text("물품 손상에 대한 어떠한 책임도 지지 않습니다.")
                }
            }
            .font(.caption)
            .foregroundColor(.gray)
                
            Spacer()
            
            HStack {
                Button(action: {
                    isShowingImageRegistrationCompleteSheet.toggle()
                    
                    if viewModel.itemIdx < 1 {
                        //등록된 물품이 2개보다 작으면 추가 물품 등록 여부 확인
                        isShowingNewItemAdditionSheet.toggle()
                    } else {
                        //등록된 물품이 2개 이상이면 예약 날짜 선택 화면으로 이동
                        isShowingReservationForm.toggle()
                    }
                }, label: {
                    Text("결함 등록 안함")
                        .bold()
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity)
                        .padding(15)
                        .background(Color(red: 242 / 255, green: 244 / 255, blue: 245 / 255))
                })
                .cornerRadius(10)
                
                Button(action: {
                    isShowingImageRegistrationCompleteSheet.toggle()
                    isShowingDefectRegistrationList.toggle()
                }, label: {
                    Text("결함 등록하기")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding(8)
                })
                .cornerRadius(10)
                .buttonStyle(.borderedProminent)
            }
            
            
            
        }
        .padding()
    }
}

#Preview {
    ImageRegistrationCompleteSheet(isShowingReservationForm: .constant(false),
                                   isShowingNewItemAdditionSheet: .constant(false),
                                   isShowingDefectRegistrationList: .constant(false),
                                   isShowingImageRegistrationCompleteSheet: .constant(false))
    .environmentObject(AppDI.shared.makeReceivingViewModel())
}
