//
//  PasswordConfirmInputBox.swift
//  Baobab
//
//  Created by 이정훈 on 6/28/24.
//

import SwiftUI

struct PasswordConfirmInputBox: View {
    @EnvironmentObject private var viewModel: SignUpViewModel
    
    var body: some View {
        VStack {
            BorderedInputBox(inputValue: $viewModel.passwordConfirm,
                             title: "비밀번호 확인",
                             placeholder: "한번 더 비밀번호를 입력하세요",
                             type: .secure)
            
            if viewModel.passwordConfirmState != .none && viewModel.passwordConfirmState != .isValid {
                SignUpCaption(caption: viewModel.passwordConfirmState.rawValue, 
                              color: viewModel.passwordConfirmState == .isValid ? .green : .red)
            } else {
                Spacer()
                    .frame(height: 17.5)
            }
        }
        .animation(.bouncy(duration: 0.5), value: viewModel.passwordConfirmState)
    }
}

#Preview {
    PasswordConfirmInputBox()
        .environmentObject(AppDI.shared.makeSignUpViewModel())
}
