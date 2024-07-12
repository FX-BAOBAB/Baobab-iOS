//
//  SignUpCompletionView.swift
//  Baobab
//
//  Created by 이정훈 on 7/1/24.
//

import SwiftUI

struct SignUpCompletionView: View {
    @Binding private(set) var isShowingCompletionView: Bool
    @Binding private(set) var isShowingAddressRegistrationForm: Bool
    @Binding private(set) var isShowingSignUpForm: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Circle()
                .fill(.blue)
                .frame(width: 50)
                .opacity(0.2)
                .overlay {
                    Image(systemName: "checkmark")
                        .foregroundColor(.blue)
                        .bold()
                }
            
            Text("회원가입 완료")
                .bold()
                .font(.title)
            
            Text("이제 Baobab의 다양한 서비스를 이용할 수 있어요!")
                .font(.subheadline)
                .padding(.top, -10)
            
            Spacer()
            
            Button(action: {
                isShowingCompletionView.toggle()
                isShowingAddressRegistrationForm.toggle()
                isShowingSignUpForm.toggle()
            }, label: {
                Text("완료")
                    .bold()
                    .padding(8)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
            })
            .buttonBorderShape(.roundedRectangle)
            .cornerRadius(10)
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

#Preview {
    SignUpCompletionView(isShowingCompletionView: .constant(true),
                         isShowingAddressRegistrationForm: .constant(true),
                         isShowingSignUpForm: .constant(true))
}
