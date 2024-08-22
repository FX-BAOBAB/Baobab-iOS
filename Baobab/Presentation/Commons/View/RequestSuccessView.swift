//
//  RequestSuccessView.swift
//  Baobab
//
//  Created by 이정훈 on 8/22/24.
//

import SwiftUI

struct RequestSuccessView: View {
    @Binding var isShowingFullScreenCover: Bool
    
    let title: String
    let navigationTitle: String
    
    var body: some View {
        VStack {
            Spacer()
            
            Image("verify")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80)
                .padding(.bottom, 10)
            
            Text(title)
                .bold()
                .foregroundStyle(.gray)
            
            Spacer()
            
            Button {
                isShowingFullScreenCover.toggle()
            } label: {
                Text("확인")
                    .bold()
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(15)
                    .background(.accent)
            }
            .cornerRadius(10)
            .padding()
        }
        .navigationTitle(navigationTitle)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    NavigationStack {
        RequestSuccessView(isShowingFullScreenCover: .constant(true),
                           title: "중고 판매로 등록 완료했어요!",
                           navigationTitle: "중고판매 등록")
    }
}
