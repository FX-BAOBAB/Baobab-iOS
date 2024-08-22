//
//  NickNameInputBox.swift
//  Baobab
//
//  Created by 이정훈 on 6/28/24.
//

import SwiftUI

struct NickNameInputBox: View {
    @EnvironmentObject private var viewModel: SignUpViewModel
    
    var body: some View {
        VStack {
            BorderedInputBox(inputValue: $viewModel.nickName,
                             title: "닉네임",
                             placeholder: "닉네임은 최대 50자, 한글만 입력",
                             type: .normal)
            
            Group {
                if viewModel.isProcessingNickNameValidation {
                    ProgressView()
                        .controlSize(.mini)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                } else if viewModel.nickNameState != .none {
                    SignUpCaption(caption: viewModel.nickNameState.rawValue,
                                  color: viewModel.nickNameState == .isValid ? .green : .red)
                }
            }
            .frame(height: 20)
        }
        .animation(.bouncy(duration: 0.5), value: viewModel.nickNameState)
    }
}

#Preview {
    NickNameInputBox()
        .environmentObject(AppDI.shared.makeSignUpViewModel())
}
