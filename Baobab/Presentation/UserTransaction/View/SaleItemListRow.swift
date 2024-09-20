//
//  SaleItemListRow.swift
//  Baobab
//
//  Created by 이정훈 on 9/12/24.
//

import SwiftUI

struct SaleItemListRow: View {
    @Binding var selectedItem: SimpleUsedItem?
    @Binding var isShowingItemDetail: Bool
    
    let usedItem: SimpleUsedItem
    
    var body: some View {
        VStack(spacing: 0) {
            ItemInfoRow(item: usedItem.item)
                .padding()
            
            Divider()
                .padding(.bottom)
            
            HStack {
                Button {
                    selectedItem = usedItem
                    isShowingItemDetail.toggle()
                } label: {
                    Text("물품 상세")
                        .font(.footnote)
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderless)
                
                Divider()
                    .frame(height: 20)
            }
            .padding(.bottom)
            
            SectionFooter()
        }
    }
}

#if DEBUG
#Preview {
    SaleItemListRow(selectedItem: .constant(nil),
                    isShowingItemDetail: .constant(false),
                    usedItem: SimpleUsedItem.sampleData)
}
#endif
