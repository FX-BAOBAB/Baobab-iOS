//
//  TopTabView.swift
//  Baobab
//
//  Created by 이정훈 on 7/24/24.
//

import SwiftUI

struct TopTabView<A: View, B: View>: View {
    private enum SelectedTab: CaseIterable {
        case first
        case second
    }
    
    @State private var selectedTab: SelectedTab = .first
    @Namespace private var animation
    
    let firstTitle: String
    let secondTitle: String
    let firstView: A
    let secondView: B
    let title: String
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .bottom) {
                HStack {
                    ForEach(SelectedTab.allCases, id:\.self) { tab in
                        VStack {
                            if tab == .first {
                                Text(firstTitle)
                                    .bold()
                                    .font(.headline)
                                    .foregroundStyle(tab == selectedTab ? .blue : .gray)
                            } else {
                                Text(secondTitle)
                                    .bold()
                                    .font(.headline)
                                    .foregroundStyle(tab == selectedTab ? .blue : .gray)
                            }
                            
                            if tab == selectedTab {
                                Rectangle()
                                    .frame(height: 3)
                                    .foregroundColor(.blue)
                                    .matchedGeometryEffect(id: "underline", in: animation)
                            } else {
                                Color.clear.frame(height: 3)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .onTapGesture {
                            withAnimation(.bouncy) {
                                selectedTab = tab
                            }
                        }
                    }
                }
                .padding(.top)
                
                Rectangle()
                    .frame(height: 0.7)
                    .foregroundColor(.gray)
            }
            
            if selectedTab == .first {
                firstView
            } else {
                secondView
            }
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    TopTabView(firstTitle: "입고 진행 중", 
               secondTitle: "입고 완료",
               firstView: EmptyView(),
               secondView: EmptyView(), 
               title: "입고 물품")
}
