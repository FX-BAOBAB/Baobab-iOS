//
//  UsedItemTop10Row.swift
//  Baobab
//
//  Created by 이정훈 on 9/10/24.
//

import SwiftUI
import SkeletonUI

struct UsedItemTop10Row: View {
    let usedItem: UsedItem
    
    var body: some View {
        AsyncImage(url: URL(string: usedItem.item.basicImages[0].imageURL)) { image in
            ZStack {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .overlay {
                        TitleOverlay(title: usedItem.title)
                            .frame(maxHeight: .infinity, alignment: .bottom)
                    }
                    .cornerRadius(10)
            }
        } placeholder: {
            Color.clear
                .skeleton(with: true,
                          shape: .rounded(.radius(10, style: .circular)))
        }
        .frame(width: UIScreen.main.bounds.width * 0.35, height: UIScreen.main.bounds.width * 0.35)
        .shadow(radius: 5)
        .padding(.leading)
    }
}

#if DEBUG
#Preview {
    UsedItemTop10Row(usedItem: UsedItem.sampleData.first!)
}
#endif
