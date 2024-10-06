//
//  CheckableItemInfoRow.swift
//  Baobab
//
//  Created by 이정훈 on 8/15/24.
//

import SwiftUI
import Kingfisher

struct SelectableItemInfoRow: View {
    @EnvironmentObject private var viewModel: ShippingApplicationViewModel
    
    let item: Item
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            HStack(alignment: .top) {
                KFImage(URL(string: item.basicImages[0].imageURL))
                    .placeholder {
                        Color.clear
                            .skeleton(with: true,
                                      shape: .rectangle)
                    }
                    .cacheMemoryOnly()
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width * 0.25, height: UIScreen.main.bounds.width * 0.25)
                    .cornerRadius(10)
                
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
                                     status: .receiving,
                                     quantity: 1,
                                     basicImages: [FileData(imageURL: "string", caption: "")],
                                     defectImages: [FileData(imageURL: "string", caption: "")],
                                     arImages: []))
    .environmentObject(AppDI.shared.makeShippingApplicationViewModel())
}
