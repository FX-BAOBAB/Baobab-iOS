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
    @ObservedObject private var viewModel: MainViewModel
    @State private var selectedTab: Tab = .home
    @Binding var isLoggedIn: Bool
    
    init(viewModel: MainViewModel, isLoggedIn: Binding<Bool>) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
        _isLoggedIn = isLoggedIn
    }
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                MainView(selectedTab: $selectedTab)
                    .toolbar(.hidden, for: .tabBar)
                    .tag(Tab.home)
                
                UsedItemList()
                    .toolbar(.hidden, for: .tabBar)
                    .tag(Tab.usedItemTransaction)
                
                NotificatioonList()
                    .toolbar(.hidden, for: .tabBar)
                    .tag(Tab.notificationList)
                
                UserInfoList(viewModel: AppDI.shared.makeUserInfoViewModel())
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
                            SettingView(viewModel: AppDI.shared.makeSettingViewModel(),
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
        .navigationBarBackButtonHidden()
        .onReceive(NotificationCenter.default.publisher(for: .refreshTokenExpiration)) {
            if let isTokenExpired = $0.userInfo?["isTokenExpired"] as? Bool,
               isTokenExpired == true {
                //로그인 화면 이동 전 토큰 삭제 진행
                viewModel.deleteToken()
            }
        }
        .onReceive(viewModel.$isTokenDeleted) {
            if $0 {
                self.isLoggedIn = false
            }
        }
    }
}

#Preview {
    NavigationStack {
        MainTabView(viewModel: AppDI.shared.makeMainViewModel(), isLoggedIn: .constant(true))
    }
}
