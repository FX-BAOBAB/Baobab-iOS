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
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                SearchedAddressView(isShowingPostCodeSearch: $isShowingPostCodeSearchForm)
                    .environmentObject(viewModel)
                    .padding(.bottom)
                
                DefaultAddressToggleButton()
                    .environmentObject(viewModel)
                
                Spacer()
            }
            .padding()
            
            VStack {
                Button(action: {
                }, label: {
                    Text("다음")
                        .bold()
                        .padding(8)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                })
                .buttonBorderShape(.roundedRectangle)
                .cornerRadius(10)
                .buttonStyle(.borderedProminent)
                .padding([.leading, .trailing, .bottom])
                .background(.white)
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            .ignoresSafeArea(.keyboard)    //TextField가 활성화 되어도 위치 고정
        }
        .navigationTitle("주소지 등록")
        .fullScreenCover(isPresented: $isShowingPostCodeSearchForm) {
            NavigationStack {
                SignUpPostCodeSearchForm(isShowingPostCodeSearchForm: $isShowingPostCodeSearchForm)
            }
        }
    }
}

#Preview {
    NavigationStack {
        AddressRegistrationForm()
            .environmentObject(AppDI.shared.signUpViewModel)
    }
}
