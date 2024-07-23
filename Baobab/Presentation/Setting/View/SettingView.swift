//
//  SettingView.swift
//  Baobab
//
//  Created by 이정훈 on 7/23/24.
//

import SwiftUI

struct SettingView: View {
    @ObservedObject private var viewModel: SettingViewModel
    @State private var isShowingLogoutAlert: Bool = false
    
    init(viewModel: SettingViewModel) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
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
                  primaryButton: .default(Text("확인")) {
                viewModel.logout()
            },
                  secondaryButton: .default(Text("취소")))
        }
    }
}

#Preview {
    NavigationStack {
        SettingView(viewModel: AppDI.shared.settingViewModel)
    }
}
