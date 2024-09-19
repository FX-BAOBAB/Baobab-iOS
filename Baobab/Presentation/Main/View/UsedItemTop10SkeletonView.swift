//
//  UsedItemTop10SkeletonView.swift
//  Baobab
//
//  Created by 이정훈 on 9/11/24.
//

import SwiftUI

struct UsedItemTop10SkeletonView: View {
    var body: some View {
        Color.clear
            .skeleton(with: true,
                      shape: .rounded(.radius(10, style: .circular)))
            .frame(width: UIScreen.main.bounds.width * 0.35, height: UIScreen.main.bounds.width * 0.35)
            .shadow(radius: 5)
            .padding(.leading)
    }
}

#Preview {
    UsedItemTop10SkeletonView()
}
