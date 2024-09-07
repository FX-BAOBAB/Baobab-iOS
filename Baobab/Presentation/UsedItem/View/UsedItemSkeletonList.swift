//
//  UsedItemSkeletonList.swift
//  Baobab
//
//  Created by 이정훈 on 9/5/24.
//

import SwiftUI

struct UsedItemSkeletonList: View {
    var body: some View {
        List {
            ForEach(0..<10, id: \.self) { _ in
                HStack(alignment: .top, spacing: 10) {
                    Color.clear
                        .skeleton(with: true,
                                  size: CGSize(width: UIScreen.main.bounds.width * 0.25,
                                               height: UIScreen.main.bounds.width * 0.25),
                                  shape: .rounded(.radius(10, style: .circular))
                        )
                    
                    VStack {
                        Color.clear
                            .skeleton(with: true,
                                      size: CGSize(width: 150, height: 18),
                                      shape: .rounded(.radius(5, style: .circular)))
                        
                        Color.clear
                            .skeleton(with: true,
                                      size: CGSize(width: 150, height: 15),
                                      shape: .rounded(.radius(5, style: .circular)))
                        
                        Color.clear
                            .skeleton(with: true,
                                      size: CGSize(width: 150, height: 15),
                                      shape: .rounded(.radius(5, style: .circular)))
                    }
                }
                .listRowSeparator(.hidden)
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    UsedItemSkeletonList()
}
