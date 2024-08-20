//
//  BaobabApp.swift
//  Baobab
//
//  Created by 이정훈 on 5/10/24.
//

import SwiftUI
import Foundation

@main
struct BaobabApp: App {
    @ObservedObject private var viewModel: LoginViewModel = AppDI.shared.loginViewModel
    
    var body: some Scene {
        WindowGroup {
            if viewModel.isShowingLaunchScreen {
                ZStack {
                    LaunchScreenView()
                        .ignoresSafeArea()
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                if UserDefaults.standard.bool(forKey: "isAutoLogin") && UserDefaults.standard.bool(forKey: "hasToken") {
                                    //자동 로그인이 활성화 되어 있으면 MainView로 이동
                                    viewModel.navigateToMain()
                                } else {
                                    //자동 로그인이 활성화 되어 있지 않으면
                                    //삭제 되지 않은 토큰 제거 후 로그인 화면으로 이동
                                    viewModel.deleteToken()
                                }
                            }
                        }
                    
                    if viewModel.isProgress {
                        ProgressView()
                            .tint(.white)
                    }
                }
            } else {
                LoginForm()
                    .environmentObject(viewModel)
            }
        }
    }
}
