//
//  MainTabView.swift
//  Baobab
//
//  Created by 이정훈 on 7/22/24.
//

import SwiftUI

enum Tab {
    case home
    case usedItemTransaction
    case notificationList
    case userInfoList
}

struct MainTabView: View {
    @State private var selectedTab: Tab = .home
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                MainView()
                    .toolbar(.hidden, for: .tabBar)
                    .tag(Tab.home)
                
                UsedItemList()
                    .toolbar(.hidden, for: .tabBar)
                    .tag(Tab.usedItemTransaction)
                
                NotificatioonList()
                    .toolbar(.hidden, for: .tabBar)
                    .tag(Tab.notificationList)
                
                UserInfoList(viewModel: AppDI.shared.userInfoViewModel, isLoggedIn: $isLoggedIn)
                    .toolbar(.hidden, for: .tabBar)
                    .tag(Tab.userInfoList)
            }
            .toolbarBackground(.white, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                switch selectedTab {
                case .home:
                    ToolbarItem(placement: .topBarLeading) {
                        Text("Baobab")
                            .bold()
                            .font(.title3)
                    }
                case .usedItemTransaction:
                    ToolbarItem(placement: .topBarLeading) {
                        Text("중고장터")
                            .bold()
                            .font(.title3)
                    }
                case .notificationList:
                    ToolbarItem(placement: .topBarLeading) {
                        Text("알림")
                            .bold()
                            .font(.title3)
                    }
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
            
            Rectangle()
                .fill(.white)
                .frame(height: UIScreen.main.bounds.width * 0.15)
                .frame(maxHeight: .infinity, alignment: .bottom)
                .edgesIgnoringSafeArea(.bottom)
            
            CustomTabbar(selectedTab: $selectedTab)
                .frame(maxHeight: .infinity, alignment: .bottom)
        }
    }
}

#Preview {
    NavigationStack {
        MainTabView(isLoggedIn: .constant(true))
    }
}
