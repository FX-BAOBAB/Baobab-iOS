//
//  LoginForm.swift
//  Baobab
//
//  Created by 이정훈 on 7/1/24.
//

import SwiftUI

struct LoginForm: View {
    @ObservedObject private var viewModel: LoginViewModel
    @State private var isShowingSignUpForm: Bool = false
    
    init(viewModel: LoginViewModel) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                Text("Login")
                    .font(.largeTitle)
                    .bold()
                    .padding(.bottom, 60)
                
                LoginInputBox(input: $viewModel.email,
                              placeholder: "이메일을 입력해주세요",
                              type: .normal)
                
                LoginInputBox(input: $viewModel.password,
                              placeholder: "비밀번호를 입력해주세요",
                              type: .secure)
                    .padding(.top, 10)
                
                AutoLogInButton()
                    .environmentObject(viewModel)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, -10)
                
                Button(action: {}, label:{
                    Text("로그인")
                        .bold()
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(8)
                })
                .buttonBorderShape(.roundedRectangle)
                .buttonStyle(.borderedProminent)
                .cornerRadius(20)
                
                HStack {
                    Button(action: {
                        isShowingSignUpForm.toggle()
                    }, label: {
                        Text("회원가입")
                            .font(.footnote)
                            .underline()
                            .foregroundColor(.black)
                    })
                    
                    Rectangle()
                        .frame(width: 1, height: 10)
                    
                    NavigationLink(destination: {}) {
                        Text("비밀번호 찾기")
                            .font(.footnote)
                            .underline()
                            .foregroundColor(.black)
                    }
                }
                .padding(.top)
            }
            .offset(y: -60)
            .padding()
            .navigationDestination(isPresented: $isShowingSignUpForm) {
                SignUpForm(viewModel: AppDI.shared.signUpViewModel, 
                           isShowingSignUpForm: $isShowingSignUpForm)
            }
        }
    }
}

#Preview {
    LoginForm(viewModel: AppDI.shared.loginViewModel)
}
