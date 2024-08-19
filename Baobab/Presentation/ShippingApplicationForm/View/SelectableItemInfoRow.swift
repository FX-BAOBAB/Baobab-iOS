//
//  CheckableItemInfoRow.swift
//  Baobab
//
//  Created by 이정훈 on 8/15/24.
//

import SwiftUI

struct SelectableItemInfoRow: View {
    @EnvironmentObject private var viewModel: ShippingApplicationViewModel
    
    let item: Item
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            HStack(alignment: .top) {
                AsyncImage(url: URL(string: item.basicImages[0].imageURL)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .cornerRadius(10)
                } placeholder: {
                    Color.clear
                        .skeleton(with: true,
                                  shape: .rounded(.radius(10, style: .circular)))
                }
                .frame(width: UIScreen.main.bounds.width * 0.25, height: UIScreen.main.bounds.width * 0.25)
                
                VStack(alignment: .leading) {
                    Text(item.name)
                        .font(.headline)
                    
                    Text(item.category.toKorCategory())
                        .foregroundStyle(.gray)
                        .font(.caption)
                    
                    Text("수량: \(item.quantity)개")
                        .foregroundStyle(.gray)
                        .font(.caption)
                }
                
                Spacer()
            }
            
            Button {
                if viewModel.selectedItems.contains(item) {
                    viewModel.removeItem(item)
                } else {
                    viewModel.appendItem(item)
                }
            } label: {
                if viewModel.selectedItems.contains(item) {
                    CheckButtonIcon(checked: true)
                } else {
                    CheckButtonIcon(checked: false)
                }
            }
        }
        .padding([.top, .bottom], 10)
    }
}

#Preview {
    SelectableItemInfoRow(item: Item(id: 0,
                                     name: "부끄부끄 마끄부끄",
                                     category: "SMALL_APPLIANCES",
                                     quantity: 1,
                                     basicImages: [ImageData(imageURL: "string", caption: "")],
                                     defectImages: [ImageData(imageURL: "string", caption: "")]))
    .environmentObject(AppDI.shared.shippingApplicationViewModel)
}
