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
                    if let category = viewModel.items[idx].itemCategory {
                        Text("\(category) × \(viewModel.items[idx].itemQuantity)")
                    }
                    
                    Spacer()
                    
                    if let price = viewModel.items[idx].itemPrice {
                        Text("\(price)원")
                    }
                }
                .font(.subheadline)
            }
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.gray)
            
            HStack {
                Text("총 결제금액:")
                
                Spacer()
                
                Text("\(viewModel.calculateTotalPrice())원")
            }
            .bold()
            .padding(.top)
        }
    }
}

#Preview {
    PaymentDetail()
        .environmentObject(AppDI.shared.receivingViewModel)
}
