//
//  ImageRegistrationCompleteSheet.swift
//  Baobab
//
//  Created by 이정훈 on 5/26/24.
//

import SwiftUI

struct ImageRegistrationCompleteSheet: View {
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
            
            HStack(spacing: 3) {
                Image(systemName: "i.circle")
                
                Text("물품 결함을 등록하지 않을시 Baobab에서는")
            }
            .font(.caption)
            .foregroundColor(.gray)
            
            Text("물품 손상에 대한 어떠한 책임도 지지 않습니다.")
                .font(.caption)
                .foregroundColor(.gray)
                
            Spacer()
            
            HStack {
                Button(action: {
                    isShowingImageRegistrationCompleteSheet.toggle()
                    isShowingNewItemAdditionSheet.toggle()
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
    ImageRegistrationCompleteSheet(isShowingNewItemAdditionSheet: .constant(false),
                                   isShowingDefectRegistrationList: .constant(false),
                                   isShowingImageRegistrationCompleteSheet: .constant(false))
}
