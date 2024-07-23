//
//  MainTabView.swift
//  Baobab
//
//  Created by 이정훈 on 7/22/24.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            UserInfoList(viewModel: AppDI.shared.userInfoViewModel)
                .tabItem {
                    Image(systemName: "person")
                    
                    Text("내 정보")
                }
        }
    }
}

#Preview {
    MainTabView()
}