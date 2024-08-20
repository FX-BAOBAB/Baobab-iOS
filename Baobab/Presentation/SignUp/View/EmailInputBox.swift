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
                             placeholder: "ex) baobab123@baobab.com", 
                             type: .normal)
            
            if viewModel.emailState == .none {
                Spacer()
                    .frame(height: 17.5)
            } else {
                SignUpCaption(caption: viewModel.emailState.rawValue, 
                              color: viewModel.emailState == .isValid ? .green : .red)
            }
        }
        .animation(.bouncy(duration: 0.5), value: viewModel.emailState)
    }
}

#Preview {
    EmailInputBox()
        .environmentObject(AppDI.shared.makeSignUpViewModel())
}
