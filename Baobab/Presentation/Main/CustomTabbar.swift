//
//  CustomTabBar.swift
//  Baobab
//
//  Created by 이정훈 on 8/5/24.
//

import SwiftUI

struct CustomTabbar: View {
    @Binding var selectedTab: Tab
    
    var body: some View {
        Rectangle()
            .fill(.white)
            .frame(height: UIScreen.main.bounds.width * 0.15)
            .clipShape(
                .rect(
                    topLeadingRadius: 20,
                    bottomLeadingRadius: 0,
                    bottomTrailingRadius: 0,
                    topTrailingRadius: 20,
                    style: .continuous
                )
            )
            .shadow(color: Color(red: 239 / 255, green: 241 / 255, blue: 243 / 255), radius: 3, y: -5)
            .overlay {
                HStack {
                    Label {
                        Text("")
                    } icon: {
                        Image(systemName: "square.grid.2x2")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 18, height: 18)
                    }
                    .environment(\.symbolVariants, selectedTab == .home ? .fill : .none)
                    .padding(.leading, 30)
                    .onTapGesture {
                        selectedTab = .home
                    }
                    
                    Spacer()
                    
                    Label {
                        EmptyView()
                    } icon: {
                        Image(systemName: "bag")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 18, height: 18)
                    }
                    .environment(\.symbolVariants, selectedTab == .usedItemTransaction ? .fill : .none)
                    .onTapGesture {
                        selectedTab = .usedItemTransaction
                    }
                    
                    Spacer()
                    
                    Label {
                        EmptyView()
                    } icon: {
                        Image(systemName: "bell")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 18, height: 18)
                    }
                    .labelStyle(.iconOnly)
                    .environment(\.symbolVariants, selectedTab == .notificationList ? .fill : .none)
                    .onTapGesture {
                        selectedTab = .notificationList
                    }
                    
                    Spacer()
                    
                    Label {
                        EmptyView()
                    } icon: {
                        Image(systemName: "person")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 18, height: 18)
                    }
                    .environment(\.symbolVariants, selectedTab == .userInfoList ? .fill : .none)
                    .padding(.trailing, 30)
                    .onTapGesture {
                        selectedTab = .userInfoList
                    }
                }
                .padding()
            }
    }
}

#Preview {
    CustomTabbar(selectedTab: .constant(.home))
}
