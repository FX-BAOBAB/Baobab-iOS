//
//  ItemQuantitySelector.swift
//  Baobab
//
//  Created by 이정훈 on 5/10/24.
//

import SwiftUI

struct ItemQuantitySelector: View {
    @EnvironmentObject private var viewModel: StoreViewModel
    
    var body: some View {
        HStack(spacing: 20) {
            Text("수량")
                .bold()
            
            Spacer()
            
            Button(action: {
                if viewModel.itemQuantity > 1 {
                    viewModel.itemQuantity -= 1
                }
            }, label: {
                MinusButtonImage()
            })
            .buttonStyle(.borderless)
            
            Text("\(viewModel.itemQuantity)")
                .underline()
            
            Button(action: {
                viewModel.itemQuantity += 1
            }, label: {
                PlusButtonImage()
            })
            .buttonStyle(.borderless)
        }
        .padding()
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(.gray, lineWidth: 1)
        }
    }
}

#Preview {
    ItemQuantitySelector()
        .environmentObject(AppDI.shared.storeViewModel)
}
