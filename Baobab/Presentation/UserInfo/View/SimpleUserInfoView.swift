//
//  SimpleUserInfoView.swift
//  Baobab
//
//  Created by 이정훈 on 7/22/24.
//

import SwiftUI
import SkeletonUI

struct SimpleUserInfoView: View {
    @EnvironmentObject private var viewModel: UserInfoViewModel
    
    var body: some View {
        HStack(spacing: 5) {
            Text(viewModel.userInfo?.name ?? "홍길동")
                .font(.title3)
                .bold()
                .foregroundStyle(.black)
                .skeleton(with: viewModel.userInfo == nil,
                          size: CGSize(width: 50, height: 30),
                          shape: .rounded(.radius(5, style: .circular)))
            
            Image(systemName: "chevron.right")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 7)
                .bold()
                .foregroundStyle(.gray)
        }
        .onAppear {
            if viewModel.userInfo == nil {
                viewModel.fetchUserInfo()
            }
        }
    }
}

#Preview {
    SimpleUserInfoView()
        .environmentObject(AppDI.shared.makeUserInfoViewModel())
}
