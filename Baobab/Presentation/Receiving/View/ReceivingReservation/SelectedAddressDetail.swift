//
//  SelectedAddressDetail.swift
//  Baobab
//
//  Created by 이정훈 on 5/23/24.
//

import SwiftUI

struct SelectedAddressDetail: View {
    @EnvironmentObject private var viewModel: ReceivingViewModel
    
    let showTag: Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                if viewModel.selectedAddress?.isBasicAddress == true && showTag {
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
            .skeleton(with: viewModel.selectedAddress == nil,
                      size: CGSize(width: UIScreen.main.bounds.width - 100, height: 80),
                      shape: .rounded(.radius(5, style: .circular)),
                      lines: 3)
            
            Spacer()
        }
        .padding()
        .background(Color(red: 241 / 255, green: 243 / 255, blue: 245 / 255))
        .cornerRadius(10)
    }
}

#Preview {
    SelectedAddressDetail(showTag: true)
        .environmentObject(AppDI.shared.receivingViewModel)
}
