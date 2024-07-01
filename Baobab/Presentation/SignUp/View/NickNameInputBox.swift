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
                             placeholder: "닉네임을 입력하세요",
                             type: .normal)
            
            if viewModel.nickNameState != .none {
                SignUpCaption(caption: viewModel.nickNameState.rawValue)
            }
        }
        .animation(.bouncy(duration: 0.5), value: viewModel.nickNameState)
    }
}

#Preview {
    NickNameInputBox()
        .environmentObject(AppDI.shared.signUpViewModel)
}
