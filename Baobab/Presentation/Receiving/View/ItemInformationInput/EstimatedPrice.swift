//
//  EstimatedPrice.swift
//  Baobab
//
//  Created by 이정훈 on 5/13/24.
//

import SwiftUI

struct EstimatedPrice: View {
    @EnvironmentObject private var viewModel: ReceivingViewModel
    
    var body: some View {
        HStack {
            Text("예상금액:")
            
            Spacer()
            
            Text("\(viewModel.items[viewModel.itemIdx].itemPrice ?? 0)원")
        }
        .bold()
        .overlay {
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.gray)
                .offset(y: 15)
        }
    }
}

#Preview {
    EstimatedPrice()
        .environmentObject(AppDI.shared.receivingViewModel)
}
