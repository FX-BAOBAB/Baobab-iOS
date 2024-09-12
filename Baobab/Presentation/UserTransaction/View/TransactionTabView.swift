//
//  TransactionTabView.swift
//  Baobab
//
//  Created by 이정훈 on 9/12/24.
//

import SwiftUI

struct TransactionTabView<A: View, B: View, C: View>: View {
    private enum SelectedTab: CaseIterable {
        case first
        case second
        case third
    }
    
    @State private var selectedTab: SelectedTab = .first
    @Environment(\.dismiss) private var dismiss
    @Namespace private var animation
    
    let firstTitle: String
    let secondTitle: String
    let thirdTitle: String
    let firstView: A
    let secondView: B
    let thirdView: C
    let title: String
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .bottom) {
                HStack {
                    ForEach(SelectedTab.allCases, id:\.self) { tab in
                        VStack {
                            Group {
                                if tab == .first {
                                    Text(firstTitle)
                                } else if tab == .second {
                                    Text(secondTitle)
                                } else {
                                    Text(thirdTitle)
                                }
                            }
                            .bold()
                            .font(.subheadline)
                            .foregroundStyle(tab == selectedTab ? .accent : .gray)
                            
                            if tab == selectedTab {
                                Rectangle()
                                    .frame(height: 3)
                                    .foregroundColor(.accent)
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
            
            switch selectedTab {
            case .first:
                firstView
            case .second:
                secondView
            case .third:
                thirdView
            }
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                }
            }
        }
    }
}

#Preview {
    TransactionTabView(firstTitle: "1",
                       secondTitle: "2",
                       thirdTitle: "3",
                       firstView: EmptyView(),
                       secondView: EmptyView(),
                       thirdView: EmptyView(),
                       title: "")
}
