//
//  ItemInfoRow.swift
//  Baobab
//
//  Created by 이정훈 on 7/25/24.
//

import SwiftUI
import SkeletonUI

struct ItemInfoRow: View {
    let item: Item
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            AsyncImage(url: URL(string: item.basicImages[0])) { image in
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
    }
}

#Preview {
    ItemInfoRow(item: Item(id: 0,
                           name: "부끄부끄 마끄부끄",
                           category: "SMALL_APPLIANCES",
                           quantity: 1,
                           basicImages: ["string"],
                           defectImages: ["string"]))
}
