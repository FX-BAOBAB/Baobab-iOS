//
//  UsedItemTop10.swift
//  Baobab
//
//  Created by 이정훈 on 9/10/24.
//

import SwiftUI

struct UsedItemTop10: View {
    @EnvironmentObject private var viewModel: MainViewModel
    @Binding var selectedTab: Tab
    
    var body: some View {
        VStack {
            HStack {
                Text("뜨고 있는 물건")
                    .font(.title3)
                    .bold()
                
                Spacer()
                
                Button {
                    selectedTab = .usedItemTrade
                } label: {
                    Text("전체보기")
                        .bold()
                        .foregroundStyle(.accent)
                }
            }
            .padding([.leading, .trailing])
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    if let usedItems = viewModel.usedItems {
                        ForEach(usedItems) { usedItem in
                            UsedItemTop10Row(usedItem: usedItem)
                        }
                    } else {
                        ForEach(0..<10, id: \.self) { _ in
                            UsedItemTop10SkeletonView()
                        }
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    UsedItemTop10(selectedTab: .constant(.home))
        .environmentObject(AppDI.shared.makeMainViewModel())
}
