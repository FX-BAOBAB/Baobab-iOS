//
//  SearchedAddressView.swift
//  Baobab
//
//  Created by 이정훈 on 6/28/24.
//

import SwiftUI

struct SearchedAddressView: View {
    @EnvironmentObject private var viewModel: SignUpViewModel
    @Binding var isShowingPostCodeSearchForm: Bool
    
    var body: some View {
        VStack {
            HStack {
                TextField("", text: Binding(
                    get: {
                        viewModel.selectedAddress?.post ?? ""
                    },
                    set: {
                        viewModel.selectedAddress?.post = $0
                    })
                )
                .foregroundColor(.gray)
                .textFieldStyle(.roundedBorder)
                .disabled(true)
                
                Button(action: {
                    isShowingPostCodeSearchForm.toggle()
                }, label: {
                    Text("주소찾기")
                        .foregroundColor(.black)
                })
                .buttonStyle(.bordered)
            }
            
            TextField("", text: Binding(
                get: {
                    viewModel.selectedAddress?.address ?? ""
                },
                set: {
                    viewModel.selectedAddress?.address = $0
                }
            ))
            .foregroundColor(.gray)
            .textFieldStyle(.roundedBorder)
            .disabled(true)
            
            TextField("", text: Binding(
                get: {
                    viewModel.selectedAddress?.detailAddress ?? ""
                },
                set: {
                    viewModel.selectedAddress?.detailAddress = $0
                }
            ))
                .foregroundColor(.gray)
                .textFieldStyle(.roundedBorder)
                .disabled(true)
        }
    }
}

#Preview {
    SearchedAddressView(isShowingPostCodeSearchForm: .constant(false))
        .environmentObject(AppDI.shared.signUpViewModel)
}
