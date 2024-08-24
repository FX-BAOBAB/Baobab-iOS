//
//  SettingView.swift
//  Baobab
//
//  Created by 이정훈 on 7/23/24.
//

import SwiftUI

struct SettingView: View {
    @StateObject private var viewModel: SettingViewModel
    @State private var isShowingLogoutAlert: Bool = false
    @Binding private var isLoggedIn: Bool
    
    init(viewModel: SettingViewModel, isLoggedIn: Binding<Bool>) {
        _viewModel = StateObject(wrappedValue: viewModel)
        _isLoggedIn = isLoggedIn
    }
    
    var body: some View {
        List {
            Section(header: Text("앱 정보")) {
                NavigationLink {
                    AppVersionView()
                        .environmentObject(viewModel)
                } label: {
                    Text("앱 정보")
                }
            }
            
            Section(header: Text("로그아웃")) {
                Button(action: {
                    isShowingLogoutAlert.toggle()
                }, label: {
                    Text("로그아웃")
                        .bold()
                        .font(.subheadline)
                        .foregroundStyle(.red)
                })
            }
        }
        .navigationTitle("설정")
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $isShowingLogoutAlert) {
            Alert(title: Text("알림"),
                  message: Text("로그아웃 할까요?"),
                  primaryButton: .default(Text("취소")),
                  secondaryButton: .default(Text("확인")) { viewModel.logout() })
        }
        .onReceive(viewModel.$isLogout) {
            if $0 {
                isLoggedIn.toggle()
            }
        }
    }
}

#Preview {
    NavigationStack {
        SettingView(viewModel: AppDI.shared.makeSettingViewModel(), 
                    isLoggedIn: .constant(true))
    }
}
