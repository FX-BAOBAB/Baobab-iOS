//
//  AddressListRow.swift
//  Baobab
//
//  Created by 이정훈 on 5/27/24.
//

import SwiftUI

struct AddressListRow<T: PostSearchable>: View {
    @EnvironmentObject private var viewModel: T
    
    let address: Address?
    
    var body: some View {
        HStack(spacing: 20) {
            Image("pin")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25)
                .skeleton(with: address == nil,
                          size: CGSize(width: 40, height: 60),
                          shape: .rounded(.radius(10, style: .circular)))
            
            VStack(alignment: .leading) {
                Text(address?.post ?? "")
                    .skeleton(with: address == nil,
                              size: CGSize(width: 50, height: 10),
                              shape: .rounded(.radius(5, style: .circular))
                    )
                
                Text(address?.address ?? "")
                    .skeleton(with: address == nil,
                              size: CGSize(width: 150, height: 10),
                              shape: .rounded(.radius(5, style: .circular))
                    )
                
                Text(address?.detailAddress ?? "")
                    .skeleton(with: address == nil,
                              size: CGSize(width: 150, height: 10),
                              shape: .rounded(.radius(5, style: .circular))
                    )
            }
            .font(.footnote)
            
            Spacer()
            
            if viewModel.selectedAddress?.id == address?.id {
                CheckMark()
                    .skeleton(with: address == nil,
                              size: CGSize(width: 20, height: 20),
                              shape: .circle)
            } else {
                Button(action: {
                    viewModel.selectedAddress = address
                }, label: {
                    EmptyCircle()
                })
            }
        }
        .padding()
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke()
                .foregroundStyle(.borderGray)
        }
    }
}

#Preview {
    AddressListRow<ReceivingViewModel>(address: Address.sampleAddressList.first!)
        .environmentObject(AppDI.shared.makeReceivingViewModel())
}
