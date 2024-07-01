//
//  KeepLoggedInButton.swift
//  Baobab
//
//  Created by 이정훈 on 7/1/24.
//

import SwiftUI

struct AutoLogInButton: View {
    @EnvironmentObject private var viewModel: LoginViewModel
    
    var body: some View {
        HStack(spacing: 5) {
            Button(action: {
                viewModel.isKeepLoggedIn.toggle()
            }, label: {
                if viewModel.isKeepLoggedIn {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 15)
                } else {
                    Circle()
                      .stroke(Color.gray, lineWidth: 1)
                      .frame(width: 15)
                }
            })
            
            Text("자동 로그인")
                .font(.caption)
        }
    }
}

#Preview {
    AutoLogInButton()
        .environmentObject(AppDI.shared.loginViewModel)
}
