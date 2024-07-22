//
//  ItemQuantitySelector.swift
//  Baobab
//
//  Created by 이정훈 on 5/10/24.
//

import SwiftUI

struct ItemQuantitySelector: View {
    @EnvironmentObject private var viewModel: ReceivingViewModel
    
    var body: some View {
        HStack(spacing: 20) {
            Text("수량")
                .font(.subheadline)
                .bold()
            
            Spacer()
            
            Button(action: {
                if viewModel.items[viewModel.itemIdx].itemQuantity > 1 {
                    viewModel.items[viewModel.itemIdx].itemQuantity -= 1
                    viewModel.updatePrice()
                }
            }, label: {
                MinusButtonImage()
            })
            .buttonStyle(.borderless)
            
            Text("\(viewModel.items[viewModel.itemIdx].itemQuantity)")
                .underline()
                .font(.subheadline)
            
            Button(action: {
                viewModel.items[viewModel.itemIdx].itemQuantity += 1
                viewModel.updatePrice()
            }, label: {
                PlusButtonImage()
            })
            .buttonStyle(.borderless)
        }
        .padding(12)
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(.gray, lineWidth: 1)
        }
    }
}

#Preview {
    ItemQuantitySelector()
        .environmentObject(AppDI.shared.receivingViewModel)
}
