//
//  SearchedAddressView.swift
//  Baobab
//
//  Created by 이정훈 on 6/28/24.
//

import SwiftUI

struct SearchedAddressView: View {
    @EnvironmentObject private var viewModel: SignUpViewModel
    @Binding var isShowingPostCodeSearch: Bool
    
    var body: some View {
        VStack {
            HStack {
                TextField("", text: $viewModel.selectedAddress.post)
                    .foregroundColor(.gray)
                    .textFieldStyle(.roundedBorder)
                    .disabled(true)
                
                Button(action: {
                    isShowingPostCodeSearch.toggle()
                }, label: {
                    Text("주소찾기")
                        .foregroundColor(.black)
                })
                .buttonStyle(.bordered)
            }
            
            TextField("", text: $viewModel.selectedAddress.address)
                .foregroundColor(.gray)
                .textFieldStyle(.roundedBorder)
                .disabled(true)
            
            TextField("", text: $viewModel.selectedAddress.detailAddress)
                .foregroundColor(.gray)
                .textFieldStyle(.roundedBorder)
                .disabled(true)
        }
    }
}

#Preview {
    SearchedAddressView(isShowingPostCodeSearch: .constant(false))
        .environmentObject(AppDI.shared.signUpViewModel)
}
