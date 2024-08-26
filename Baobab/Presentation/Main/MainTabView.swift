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
        VStack(spacing: 0) {
            switch selectedTab {
            case .home:
                MainView(selectedTab: $selectedTab)
            case .usedItemTransaction:
                UsedItemList()
            case .notificationList:
                NotificatioonList()
            case .userInfoList:
                UserInfoList(viewModel: AppDI.shared.makeUserInfoViewModel(), isLoggedIn: $isLoggedIn)
            }
            
            CustomTabbar(selectedTab: $selectedTab)
        }
        .toolbarBackground(.white, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
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
