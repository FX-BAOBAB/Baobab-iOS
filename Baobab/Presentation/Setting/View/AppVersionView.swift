//
//  AppVersionView.swift
//  Baobab
//
//  Created by 이정훈 on 8/24/24.
//

import SwiftUI

struct AppVersionView: View {
    @EnvironmentObject private var viewModel: SettingViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Image("BaobabLogo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100)
            
            Text("현재 버전: \(viewModel.appVersion)")
        }
        .navigationTitle("앱 정보")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.getAppVersion()
        }
    }
}

#Preview {
    AppVersionView()
        .environmentObject(AppDI.shared.makeSettingViewModel())
}
