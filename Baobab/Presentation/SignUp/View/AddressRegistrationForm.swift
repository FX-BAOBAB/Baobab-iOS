//
//  AddressRegistrationForm.swift
//  Baobab
//
//  Created by 이정훈 on 6/28/24.
//

import SwiftUI

struct AddressRegistrationForm: View {
    @EnvironmentObject private var viewModel: SignUpViewModel
    @State private var isShowingPostCodeSearchForm: Bool = false
    @State private var isShowingCompletionView: Bool = false
    @State private var isShowingEmptyAddressAlert: Bool = false
    @Binding private(set) var isShowingSignUpForm: Bool
    @Binding private(set) var isShowingAddressRegistrationForm: Bool
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                SearchedAddressView(isShowingPostCodeSearchForm: $isShowingPostCodeSearchForm)
                    .environmentObject(viewModel)
                    .padding(.bottom)
                
                DefaultAddressToggleButton()
                    .environmentObject(viewModel)
                
                Spacer()
            }
            .padding()
            
            Button(action: {
                if viewModel.detailedAddressInput.isEmpty {
                    viewModel.alertType = .addressEmpty
                    viewModel.isShowingAlert.toggle()
                } else {
                    viewModel.signUp()
                }
            }, label: {
                Text("다음")
                    .bold()
                    .padding(8)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
            })
            .cornerRadius(10)
            .buttonStyle(.borderedProminent)
            .padding([.leading, .trailing, .bottom])
            .background(.white)
            .frame(maxHeight: .infinity, alignment: .bottom)
            .ignoresSafeArea(.keyboard)    //TextField가 활성화 되어도 위치 고정
            
            if viewModel.isProgress {
                CustomProgressView()
            }
        }
        .navigationTitle("주소지 등록")
        .fullScreenCover(isPresented: $isShowingPostCodeSearchForm) {
            NavigationStack {
                SignUpPostCodeSearchForm(isShowingPostCodeSearchForm: $isShowingPostCodeSearchForm)
            }
        }
        .navigationDestination(isPresented: $isShowingCompletionView) {
            SignUpCompletionView(isShowingCompletionView: $isShowingCompletionView,
                                 isShowingAddressRegistrationForm: $isShowingAddressRegistrationForm,
                                 isShowingSignUpForm: $isShowingSignUpForm)
        }
        .alert(isPresented: $viewModel.isShowingAlert) {
            switch viewModel.alertType {
            case .addressEmpty:
                Alert(title: Text("알림"),
                      message: Text("방문지 정보를 정확하게 입력해 주세요"),
                      dismissButton: .default(Text("확인")))
            case .signUpError:
                Alert(title: Text("알림"), message: Text(viewModel.responseMessage))
            case .signUpSuccess:
                Alert(title: Text("회원가입 성공"),
                      message: Text(viewModel.responseMessage),
                      dismissButton: .default(Text("확인")) {
                    isShowingAddressRegistrationForm.toggle()
                    isShowingSignUpForm.toggle()
                })
            case .none:
                Alert(title: Text(""))
            }
        }
        .onAppear {
            if viewModel.selectedAddress == nil {
                viewModel.selectedAddress = Address(id: UUID().hashValue, address: "", detailAddress: "", post: "", isBasicAddress: false)
            }
        }
    }
}

#Preview {
    NavigationStack {
        AddressRegistrationForm(isShowingSignUpForm: .constant(true),
                                isShowingAddressRegistrationForm: .constant(true))
            .environmentObject(AppDI.shared.makeSignUpViewModel())
    }
}
