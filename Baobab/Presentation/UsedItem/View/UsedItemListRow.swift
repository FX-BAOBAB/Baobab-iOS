//
//  UsedItemListRow.swift
//  Baobab
//
//  Created by 이정훈 on 9/4/24.
//

import SwiftUI
import Kingfisher

struct UsedItemListRow: View {
    let usedItem: UsedItem
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            KFImage(URL(string: usedItem.item.basicImages[0].imageURL))
                .placeholder {
                    Color.clear
                        .skeleton(with: true, shape: .rectangle)
                }
                .cacheMemoryOnly()
                .resizable()
                .frame(width: UIScreen.main.bounds.width * 0.25, height: UIScreen.main.bounds.width * 0.25)
                .cornerRadius(10)
            
            VStack(alignment: .leading) {
                Text(usedItem.title)
                    .bold()
                
                Text(Date.toSimpleFormat(from: usedItem.postedAt, format: .withoutTime))
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                
                HStack(spacing: 0) {
                    Text("\(usedItem.price)")
                        .bold()
                        .foregroundStyle(.accent)
                    
                    Text("원")
                }
                .font(.subheadline)
            }
            
            Spacer()
        }
    }
}

#if DEBUG
#Preview {
    UsedItemListRow(usedItem: UsedItem.sampleData[0])
}
#endif
