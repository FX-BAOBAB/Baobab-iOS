//
//  UsedTradeListRow.swift
//  Baobab
//
//  Created by 이정훈 on 9/4/24.
//

import SwiftUI

struct UsedTradeListRow: View {
    let usedItem: UsedItem
    
    var body: some View {
        HStack(alignment: .top) {
            AsyncImage(url: URL(string: usedItem.item.basicImages[0].imageURL)) { image in
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
                Text(usedItem.title)
                    .bold()
                
                Text(Date.toSimpleFormat(from: usedItem.postedAt, format: .full))
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
    UsedTradeListRow(usedItem: UsedItem.sampleData[0])
}
#endif
