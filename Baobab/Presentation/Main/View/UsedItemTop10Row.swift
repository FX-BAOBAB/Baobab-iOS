//
//  UsedItemTop10Row.swift
//  Baobab
//
//  Created by 이정훈 on 9/10/24.
//

import SwiftUI
import Kingfisher

struct UsedItemTop10Row: View {
    let usedItem: UsedItem
    
    var body: some View {
        KFImage(URL(string: usedItem.item.basicImages[0].imageURL))
            .placeholder {
                Color.clear
                    .skeleton(with: true,
                              shape: .rectangle)
            }
            .cacheMemoryOnly()
            .resizable()
            .overlay {
                TitleOverlay(title: usedItem.title)
                    .frame(maxHeight: .infinity, alignment: .bottom)
            }
            .frame(width: UIScreen.main.bounds.width * 0.35, height: UIScreen.main.bounds.width * 0.35)
            .cornerRadius(10)
            .shadow(radius: 5)
            .padding(.leading)
    }
}

#if DEBUG
#Preview {
    UsedItemTop10Row(usedItem: UsedItem.sampleData.first!)
}
#endif
