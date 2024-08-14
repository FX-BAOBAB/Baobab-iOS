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
        HStack {
            Image(systemName: "person.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width * 0.12)
                .foregroundColor(.gray)
                .skeleton(with: viewModel.userInfo == nil,
                          size: CGSize(width: UIScreen.main.bounds.width * 0.12, height: UIScreen.main.bounds.width * 0.12),
                          shape: .rounded(.radius(10, style: .circular)))
            
            VStack(alignment: .leading) {
                Text(viewModel.userInfo?.name ?? "홍길동")
                    .bold()
                    .skeleton(with: viewModel.userInfo == nil,
                              size: CGSize(width: 100, height: 20),
                              shape: .rounded(.radius(5, style: .circular)))
                
                Text("상세보기")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .skeleton(with: viewModel.userInfo == nil,
                              size: CGSize(width: 100, height: 15),
                              shape: .rounded(.radius(5, style: .circular)))
            }
            
            Spacer()
        }
        .padding([.top, .bottom], 10)
        .onAppear {
            if viewModel.userInfo == nil {
                viewModel.fetchUserInfo()
            }
        }
    }
}

#Preview {
    SimpleUserInfoView()
        .environmentObject(AppDI.shared.userInfoViewModel)
}
