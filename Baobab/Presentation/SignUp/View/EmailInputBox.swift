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
        VStack {
            BorderedInputBox(inputValue: $viewModel.email,
                             title: "이메일",
                             placeholder: "ex) baobab123@baobab.com")
            
            if viewModel.emailState != .none {
                SignUpCaption(caption: viewModel.emailState.rawValue)
            } else {
                Spacer()
                    .frame(height: 17.5)
            }
        }
        .animation(.bouncy(duration: 0.5), value: viewModel.emailState)
    }
}

#Preview {
    EmailInputBox()
        .environmentObject(AppDI.shared.signUpViewModel)
}
