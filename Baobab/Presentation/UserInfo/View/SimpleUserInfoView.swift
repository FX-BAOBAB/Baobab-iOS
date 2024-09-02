//
//  SimpleUserInfoView.swift
//  Baobab
//
//  Created by 이정훈 on 7/22/24.
//

import SwiftUI
import SkeletonUI

struct SimpleUserInfoView: View {
    @Binding var userInfo: UserInfo?
    
    var body: some View {
        HStack(spacing: 5) {
            Text(userInfo?.name ?? "홍길동")
                .font(.title3)
                .bold()
                .foregroundStyle(.black)
                .skeleton(with: userInfo == nil,
                          size: CGSize(width: 50, height: 30),
                          shape: .rounded(.radius(5, style: .circular)))
            
            Image(systemName: "chevron.right")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 7)
                .bold()
                .foregroundStyle(.gray)
        }
    }
}

#Preview {
    SimpleUserInfoView(userInfo: .constant(UserInfo(id: 0, name: "홍길동", email: "gildong@baobab.com", role: "unkown")))
}
