//
//  RequestFailureView.swift
//  Baobab
//
//  Created by 이정훈 on 8/22/24.
//

import SwiftUI

struct RequestFailureView: View {
    @Binding var isShowingFullScreenCover: Bool
    
    let title: String
    let subTitle: String
    let navigationTitle: String
    
    var body: some View {
        VStack {
            Spacer()
            
            Image("xicon")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80)
                .padding(.bottom, 10)
            
            Text(title)
                .bold()
                .foregroundStyle(.gray)
            
            Text(subTitle)
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
    }
}

#Preview {
    NavigationStack {
        RequestFailureView(isShowingFullScreenCover: .constant(true),
                           title: "중고 판매로 등록 실패했어요.",
                           subTitle: "고객센터로 문의 바랍니다.",
                           navigationTitle: "중고판매 등록")
    }
}
