//
//  MainView.swift
//  Baobab
//
//  Created by 이정훈 on 8/5/24.
//

import SwiftUI

struct MainView: View {
    @State private var isShowingReceivingForm: Bool = false
    @Binding var selectedTab: Tab
    
    var body: some View {
        ScrollView {
            HStack(spacing: 15) {
                Button(action: {
                    isShowingReceivingForm.toggle()
                }) {
                    MainNavigationBlock(title: "입고",
                                        image: "truck.box.fill",
                                        background: Color(red: 76 / 255, green: 110 / 255, blue: 245 / 255),
                                        tintColor: Color(red: 237 / 255, green: 242 / 255, blue: 255 / 255))
                }
                
                Button(action: {
                    selectedTab = .usedItemTransaction
                }) {
                    MainNavigationBlock(title: "중고거래",
                                        image: "bag.fill",
                                        background: Color(red: 253 / 255, green: 126 / 255, blue: 20 / 255),
                                        tintColor: Color(red: 255 / 255, green: 244 / 255, blue: 230 / 255))
                }
            }
            .padding(.top)
        }
        .padding([.leading, .trailing])
        .fullScreenCover(isPresented: $isShowingReceivingForm) {
            NavigationStack {
                ReceivingIntroView(isShowingReceivingForm: $isShowingReceivingForm)
            }
        }
    }
}

#Preview {
    MainView(selectedTab: .constant(.home))
}
