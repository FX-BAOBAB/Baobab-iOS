//
//  EmailInputBox.swift
//  Baobab
//
//  Created by 이정훈 on 6/28/24.
//

import SwiftUI

struct EmailInputBox: View {
    @EnvironmentObject private var viewModel: SignUpViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            BorderedInputBox(inputValue: $viewModel.email,
                             title: "이메일",
                             placeholder: "ex) baobab123@baobab.com", 
                             type: .normal)
            
            Group {
                if viewModel.isProceccingEmailValidation {
                    ProgressView()
                        .controlSize(.mini)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                } else if viewModel.emailState == .none {
                    Color.clear
                } else {
                    SignUpCaption(caption: viewModel.emailState.rawValue,
                                  color: viewModel.emailState == .isValid ? .green : .red)
                }
            }
            .frame(height: 20)
        }
        .animation(.bouncy(duration: 0.5), value: viewModel.emailState)
    }
}

#Preview {
    EmailInputBox()
        .environmentObject(AppDI.shared.makeSignUpViewModel())
}
