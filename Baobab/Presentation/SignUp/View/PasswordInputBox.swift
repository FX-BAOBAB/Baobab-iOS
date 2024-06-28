//
//  PasswordInputBox.swift
//  Baobab
//
//  Created by 이정훈 on 6/28/24.
//

import SwiftUI

struct PasswordInputBox: View {
    @EnvironmentObject private var viewModel: SignUpViewModel
    
    var body: some View {
        VStack {
            BorderedInputBox(inputValue: $viewModel.password,
                             title: "비밀번호",
                             placeholder: "대문자, 소문자, 숫자, 특수문자 포함 8자리 이상")
            
            if viewModel.passwordState != .none {
                SignUpCaption(caption: viewModel.passwordState.rawValue)
            } else {
                Spacer()
                    .frame(height: 17.5)
            }
        }
        .animation(.bouncy(duration: 0.5), value: viewModel.passwordState)
    }
}

#Preview {
    PasswordInputBox()
        .environmentObject(AppDI.shared.signUpViewModel)
}
