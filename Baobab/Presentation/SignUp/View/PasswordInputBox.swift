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
                             placeholder: "대문자, 소문자, 숫자, 특수문자 포함 8자리 이상",
                             type: .secure)
            
            if viewModel.passwordState == .none || viewModel.passwordState == .isValid {
                Spacer()
                    .frame(height: 17.5)
            } else {
                SignUpCaption(caption: viewModel.passwordState.rawValue, 
                              color: viewModel.passwordState == .isValid ? .green : .red)
            }
        }
        .animation(.bouncy(duration: 0.5), value: viewModel.passwordState)
    }
}

#Preview {
    PasswordInputBox()
        .environmentObject(AppDI.shared.makeSignUpViewModel())
}
