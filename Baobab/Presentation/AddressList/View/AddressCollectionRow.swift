//
//  AddressCollectionRow.swift
//  Baobab
//
//  Created by 이정훈 on 10/16/24.
//

import SwiftUI

struct AddressCollectionRow: View {
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
    AddressCollectionRow(address: Address.sampleAddressList.first!)
}
