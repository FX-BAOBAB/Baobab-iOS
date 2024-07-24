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
            Button(action: {
                isShowingLogoutAlert.toggle()
            }, label: {
                Text("로그아웃")
                    .bold()
                    .font(.subheadline)
                    .foregroundStyle(.red)
                    .padding([.top, .bottom], 10)
            })
        }
        .listStyle(.plain)
        .navigationTitle("설정")
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $isShowingLogoutAlert) {
            Alert(title: Text("알림"),
                  message: Text("로그아웃 할까요?"),
                  primaryButton: .default(Text("확인")) { viewModel.logout() },
                  secondaryButton: .default(Text("취소")))
        }
        .fork { this in
            if #available(iOS 17.0, *) {
                this.onChange(of: viewModel.isLogout) {
                    if viewModel.isLogout {
                        isLoggedIn.toggle()    //로그인 화면으로 돌아감
                    }
                }
            } else {
                this.onChange(of: viewModel.isLogout, perform: { isLogout in
                    if isLogout {
                        isLoggedIn.toggle()    //로그인 화면으로 돌아감
                    }
                })
            }
        }
    }
}

#Preview {
    NavigationStack {
        SettingView(viewModel: AppDI.shared.settingViewModel, 
                    isLoggedIn: .constant(true))
    }
}
