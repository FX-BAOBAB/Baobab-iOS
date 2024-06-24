//
//  SelectedAddressDetail.swift
//  Baobab
//
//  Created by 이정훈 on 5/23/24.
//

import SwiftUI

struct SelectedAddressDetail: View {
    @EnvironmentObject private var viewModel: ReceivingViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            if viewModel.selectedAddress?.isBasicAddress == true {
                Text("기본 주소")
                    .padding([.leading, .trailing], 8)
                    .padding([.top, .bottom], 6)
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(5)
                    .font(.caption)
                    .bold()
                    .padding(.bottom, 5)
            }
            
            Text(viewModel.selectedAddress?.post ?? "00000")
                .underline()
                .padding(.bottom, 8)
            
            Text(viewModel.selectedAddress?.address ?? "주소")
                .underline()
                .padding(.bottom, 8)
            
            Text(viewModel.selectedAddress?.detailAddress ?? "상세주소")
                .underline()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    SelectedAddressDetail()
        .environmentObject(AppDI.shared.receivingViewModel)
}
