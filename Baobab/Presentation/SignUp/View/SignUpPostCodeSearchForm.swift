//
//  SignUpPostCodeSearch.swift
//  Baobab
//
//  Created by 이정훈 on 6/28/24.
//

import SwiftUI

struct SignUpPostCodeSearchForm: View {
    @EnvironmentObject private var viewModel: SignUpViewModel
    @State private var isShowingDetailAddressForm: Bool = false
    @State private var isProgress: Bool = true
    @Binding var isShowingPostCodeSearchForm: Bool
    
    var body: some View {
        ZStack {
            PostSearchWebView<SignUpViewModel>(isShowingDetailAddressForm: $isShowingDetailAddressForm,
                                               isProgress: $isProgress)
                .environmentObject(viewModel)
            
            if isProgress {
                ProgressView()
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    isShowingPostCodeSearchForm.toggle()
                }, label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.black)
                })
            }
        }
        .navigationDestination(isPresented: $isShowingDetailAddressForm) {
            DetailAddressMap<SignUpViewModel>(isShowingAddressList: .constant(true),
                                              isShowingPostSearchForm: $isShowingPostCodeSearchForm)
                .environmentObject(viewModel)
        }
    }
}

#Preview {
    NavigationStack {
        SignUpPostCodeSearchForm(isShowingPostCodeSearchForm: .constant(true))
            .environmentObject(AppDI.shared.makeSignUpViewModel())
    }
}
