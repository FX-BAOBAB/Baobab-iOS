//
//  PaymentDetail.swift
//  Baobab
//
//  Created by 이정훈 on 6/25/24.
//

import SwiftUI

struct PaymentDetail: View {
    @EnvironmentObject private var viewModel: ReceivingViewModel
    
    var body: some View {
        VStack {
            ForEach(0..<viewModel.itemIdx + 1, id: \.self) { idx in
                HStack {
                    if let category = viewModel.items[idx].korCategory {
                        Text("\(category) × \(viewModel.items[idx].itemQuantity)")
                    }
                    
                    Spacer()
                    
                    if let price = viewModel.items[idx].itemPrice {
                        Text("\(price)원")
                    }
                }
                .font(.subheadline)
            }
            
            Divider()
            
            HStack(spacing: 5) {
                Text("총 결제금액:")
                
                Spacer()
                
                Text("\(viewModel.totalPrice)")
                    .foregroundStyle(.accent)
                
                Text("원")
            }
            .bold()
            .padding([.top, .bottom])
            
            Divider()
        }
    }
}

#Preview {
    PaymentDetail()
        .environmentObject(AppDI.shared.receivingViewModel)
}
