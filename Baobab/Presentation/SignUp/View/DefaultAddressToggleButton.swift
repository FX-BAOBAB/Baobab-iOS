//
//  DefaultAddressToggle.swift
//  Baobab
//
//  Created by 이정훈 on 6/28/24.
//

import SwiftUI

struct DefaultAddressToggleButton: View {
    @EnvironmentObject private var viewModel: SignUpViewModel
    
    var body: some View {
        HStack(spacing: 10) {
            Button(action: {
                viewModel.selectedAddress?.isBasicAddress.toggle()
            }, label: {
                if viewModel.selectedAddress?.isBasicAddress == true {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 15)
                } else {
                    Circle()
                      .stroke(Color.gray, lineWidth: 1)
                      .frame(width: 15)
                }
            })
            
            Text("위의 주소를 기본 주소지로 등록하기")
                .font(.callout)
        }
    }
}

#Preview {
    DefaultAddressToggleButton()
        .environmentObject(AppDI.shared.signUpViewModel)
}
