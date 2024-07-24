//
//  MainTabView.swift
//  Baobab
//
//  Created by 이정훈 on 7/22/24.
//

import SwiftUI

struct MainTabView: View {
    enum Tab {
        case userInfoList
    }
    
    @State private var selectedTab: Tab = .userInfoList
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        TabView(selection: $selectedTab) {
            UserInfoList(viewModel: AppDI.shared.userInfoViewModel,
                         isLoggedIn: $isLoggedIn)
                .tabItem {
                    Image(systemName: "person")
                    
                    Text("내 정보")
                }
                .tag(Tab.userInfoList)
        }
        .toolbar {
            switch selectedTab {
            case .userInfoList:
                ToolbarItem(placement: .topBarLeading) {
                    Text("내 정보")
                        .bold()
                        .font(.title3)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: {
                        SettingView(viewModel: AppDI.shared.settingViewModel,
                                    isLoggedIn: $isLoggedIn)
                    }) {
                        Image(systemName: "gearshape.fill")
                            .foregroundStyle(.gray)
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        MainTabView(isLoggedIn: .constant(true))
    }
}
