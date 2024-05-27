//
//  NewItemAdditionSheet.swift
//  Baobab
//
//  Created by 이정훈 on 5/27/24.
//

import SwiftUI

struct NewItemAdditionSheet: View {
    @EnvironmentObject private var viewModel: StoreViewModel
    @Binding var isShowingReservationForm: Bool
    @Binding var isShowingItemInformationForm: Bool
    @Binding var isShowingNewItemAdditionSheet: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("추가 물품을 등록할까요?")
                .bold()
                .font(.title2)
                .padding(.top)
            
            Text("하나의 물품을 추가로 입고할 수 있어요")
                .padding(.bottom)
            
            Spacer()
            
            HStack {
                Button(action: {
                    isShowingNewItemAdditionSheet.toggle()
                    isShowingReservationForm.toggle()
                }, label: {
                    Text("물품 추가 안함")
                        .bold()
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity)
                        .padding(15)
                        .background(Color(red: 242 / 255, green: 244 / 255, blue: 245 / 255))
                })
                .cornerRadius(10)
                
                Button(action: {
                    viewModel.itemIdx += 1    //물품 인덱스 1증가
                    isShowingNewItemAdditionSheet.toggle()
                    isShowingItemInformationForm.toggle()
                }, label: {
                    Text("물품 추가하기")
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
    NewItemAdditionSheet(isShowingReservationForm: .constant(false),
                         isShowingItemInformationForm: .constant(false),
                         isShowingNewItemAdditionSheet: .constant(false))
}
