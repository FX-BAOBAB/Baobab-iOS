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
        VStack(alignment: .leading) {
            Text("수량")
                .bold()
                .font(.footnote)
                .foregroundStyle(.gray)
                .padding(.leading, 5)
            
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(red: 248 / 255, green: 249 / 255, blue: 250 / 255))
                .frame(height: 50)
                .overlay {
                    HStack(spacing: 20) {
                        Text("입고 수량")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                        
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
                    .padding()
                }
        }
    }
}

#Preview {
    ItemQuantitySelector()
        .environmentObject(AppDI.shared.receivingViewModel)
}
