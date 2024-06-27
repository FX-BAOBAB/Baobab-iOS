//
//  AddressListRow.swift
//  Baobab
//
//  Created by 이정훈 on 5/27/24.
//

import SwiftUI

struct AddressListRow: View {
    @EnvironmentObject private var viewModel: ReceivingViewModel
    
    let address: Address
    
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: "mappin.and.ellipse")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25)
            
            VStack(alignment: .leading) {
                Text(address.post)
                
                Text(address.address)
                
                Text(address.detailAddress)
            }
            .font(.footnote)
            
            Spacer()
            
            if viewModel.selectedAddress?.id == address.id {
                CheckMark()
            } else {
                Button(action: {
                    viewModel.selectedAddress = address
                }, label: {
                    EmptyCircle()
                })
            }
        }
    }
}

#Preview {
    AddressListRow(address: Address.sampleAddressList.first!)
        .environmentObject(AppDI.shared.receivingViewModel)
}
