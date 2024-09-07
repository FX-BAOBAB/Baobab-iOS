//
//  MainTabView.swift
//  Baobab
//
//  Created by 이정훈 on 7/22/24.
//

import SwiftUI

enum Tab {
    case home
    case usedItemTrade
    case notification
    case userInfo
}

struct MainTabView: View {
    @ObservedObject private var viewModel: MainViewModel
    @State private var selectedTab: Tab = .home
    @State private var isShowingUserInfoView: Bool = false
    @State private var isShowingUsedItemSearch: Bool = false
    @Binding var isLoggedIn: Bool
    
    init(viewModel: MainViewModel, isLoggedIn: Binding<Bool>) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
        _isLoggedIn = isLoggedIn
        
        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = .clear
        appearance.backgroundColor = .white
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            MainView()
                .tabItem {
                    Image(systemName: "house")
                        .environment(\.symbolVariants, selectedTab == .home ? .fill : .none)
                    
                    Text("홈")
                }
                .tag(Tab.home)
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarBackground(.white, for: .tabBar)
            
            UsedItemList(viewModel: AppDI.shared.makeUsedTradeViewModel())
                .tabItem {
                    Image(systemName: "bag")
                        .environment(\.symbolVariants, selectedTab == .usedItemTrade ? .fill : .none)
                    
                    Text("중고거래")
                }
                .tag(Tab.usedItemTrade)
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarBackground(.white, for: .tabBar)
            
            NotificatioonList()
                .tabItem {
                    Image(systemName: "bell")
                        .environment(\.symbolVariants, selectedTab == .notification ? .fill : .none)
                    
                    Text("알림")
                }
                .tag(Tab.notification)
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarBackground(.white, for: .tabBar)
            
            UserInfoList(isLoggedIn: $isLoggedIn)
                .tabItem {
                    Image(systemName: "person")
                        .environment(\.symbolVariants, selectedTab == .userInfo ? .fill : .none)
                    
                    Text("내 정보")
                }
                .tag(Tab.userInfo)
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarBackground(.white, for: .tabBar)
        }
        .accentColor(.black)
        .onAppear {
            if viewModel.userInfo == nil {
                viewModel.fetchUserInfo()
            }
        }
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
        .fullScreenCover(isPresented: $isShowingUserInfoView) {
            NavigationStack {
                UserInfoView(viewModel: AppDI.shared.makeUserInfoViewModel(),
                             userInfo: $viewModel.userInfo,
                             isShowingUserInfoView: $isShowingUserInfoView)
            }
        }
        .fullScreenCover(isPresented: $isShowingUsedItemSearch) {
            NavigationStack {
                UsedItemSearchView(viewModel: AppDI.shared.makeUsedTradeSearchViewModel(),
                                    isShowingUsedItemSearch: $isShowingUsedItemSearch)
            }
        }
        .toolbar {
            switch selectedTab {
            case .home:
                ToolbarItem(placement: .topBarLeading) {
                    Text("Baobab")
                        .bold()
                        .font(.title3)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        
                    } label: {
                        Image(systemName: "paperplane")
                            .foregroundStyle(.black)
                    }
                }
            case .usedItemTrade:
                ToolbarItem(placement: .topBarLeading) {
                    Text("중고거래")
                        .bold()
                        .font(.title3)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isShowingUsedItemSearch.toggle()
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(.black)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "paperplane")
                            .foregroundStyle(.black)
                    }
                }
            case .notification:
                ToolbarItem(placement: .topBarLeading) {
                    Text("알림")
                        .bold()
                        .font(.title3)
                }
            case .userInfo:
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        isShowingUserInfoView.toggle()
                    } label: {
                        SimpleUserInfoView(userInfo: $viewModel.userInfo)
                    }
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
    }
}

#Preview {
    NavigationStack {
        MainTabView(viewModel: AppDI.shared.makeMainViewModel(), isLoggedIn: .constant(true))
    }
}
