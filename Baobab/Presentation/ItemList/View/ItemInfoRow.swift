//
//  ItemInfoRow.swift
//  Baobab
//
//  Created by 이정훈 on 7/25/24.
//

import SwiftUI
import Kingfisher

struct ItemInfoRow: View {
    let item: Item
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            KFImage(URL(string: item.basicImages[0].imageURL))
                .placeholder {
                    Color.clear
                        .skeleton(with: true, shape: .rounded(.radius(10, style: .circular)))
                }
                .cacheMemoryOnly()
                .resizable()
                .cornerRadius(10)
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
    }
}

#if DEBUG
#Preview {
    ItemInfoRow(item: Item(id: 0,
                           name: "부끄부끄 마끄부끄",
                           category: "SMALL_APPLIANCES", 
                           status: .receiving,
                           quantity: 1,
                           basicImages: [FileData(imageURL: "string", caption: "")],
                           defectImages: [FileData(imageURL: "string", caption: "")],
                           arImages: []))
}
#endif
