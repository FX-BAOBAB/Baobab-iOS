//
//  ItemListRow.swift
//  Baobab
//
//  Created by 이정훈 on 6/25/24.
//

import SwiftUI

struct ItemListRow: View {
    @EnvironmentObject private var viewModel: ReceivingViewModel
    
    let idx: Int
    
    var body: some View {
        HStack {
            if let imageData = viewModel.items[idx].itemImages[0],
               let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width * 0.15,
                           height: UIScreen.main.bounds.width * 0.15)
                    .cornerRadius(8)
            } else {
                DefaultItemImage()
            }
            
            VStack(alignment: .leading) {
                Text(viewModel.items[idx].itemName)
                
                Text(viewModel.items[idx].korCategory)
                
                Text("\(viewModel.items[idx].itemQuantity)개")
            }
            .font(.caption)
            
            Spacer()
        }
        .padding()
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 1.0)
                .foregroundColor(.borderGray)
        }
    }
}

#Preview {
    ItemListRow(idx: 0)
        .environmentObject(AppDI.shared.makeReceivingViewModel())
}
