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
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                if UserDefaults.standard.bool(forKey: "isAutoLogin") {
                                    //자동 로그인이 활성화 되어 있으면
                                    //기존의 refreshToken을 활용하여 accessToken 업데이트
                                    viewModel.updateRefreshToken()
                                } else {
                                    //자동 로그인이 활성화 되어 있지 않으면
                                    //로그인 화면으로 이동
                                    viewModel.isShowingLaunchScreen = false
                                }
                            }
                        }
                    
                    if viewModel.isLoginProgress {
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
