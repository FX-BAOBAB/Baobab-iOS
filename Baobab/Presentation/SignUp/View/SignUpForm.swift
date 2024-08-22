//
//  SignUpForm.swift
//  Baobab
//
//  Created by 이정훈 on 6/27/24.
//

import SwiftUI

struct SignUpForm: View {
    @ObservedObject private var viewModel: SignUpViewModel
    @State private var isShowingInvalidInputAlert: Bool = false
    @State private var isShowingAddressRegistrationForm: Bool = false
    @Binding private(set) var isShowingSignUpForm: Bool
    
    init(viewModel: SignUpViewModel, isShowingSignUpForm: Binding<Bool>) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
        _isShowingSignUpForm = isShowingSignUpForm
    }
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 15) {
                    EmailInputBox()
                        .environmentObject(viewModel)
                    
                    PasswordInputBox()
                        .environmentObject(viewModel)
                    
                    PasswordConfirmInputBox()
                        .environmentObject(viewModel)
                    
                    NickNameInputBox()
                        .environmentObject(viewModel)
                }
                .navigationTitle("회원가입")
                .padding()
            }
            
            VStack {
                Button {
                    isShowingAddressRegistrationForm.toggle()
                } label: {
                    Text("다음")
                        .bold()
                        .padding(8)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                }
                .buttonBorderShape(.roundedRectangle)
                .cornerRadius(10)
                .buttonStyle(.borderedProminent)
                .padding([.leading, .trailing, .bottom])
                .background(.white)
                .disabled(!(viewModel.isAllValid))
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            .ignoresSafeArea(.keyboard)    //TextField가 활성화 되어도 위치 고정
        }
        .navigationBarTitleDisplayMode(.large)
        .navigationDestination(isPresented: $isShowingAddressRegistrationForm) {
            AddressRegistrationForm(isShowingSignUpForm: $isShowingSignUpForm,
                                    isShowingAddressRegistrationForm: $isShowingAddressRegistrationForm)
                .environmentObject(viewModel)
        }
    }
}

#Preview {
    NavigationStack {
        SignUpForm(viewModel: AppDI.shared.makeSignUpViewModel(), 
                   isShowingSignUpForm: .constant(true))
    }
}
