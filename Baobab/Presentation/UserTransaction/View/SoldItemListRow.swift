//
//  TransactionListRow.swift
//  Baobab
//
//  Created by 이정훈 on 9/10/24.
//

import SwiftUI

struct SoldItemListRow: View {
    @State private var isShowingAlert: Bool = false
    @Binding var selectedItem: SimpleUsedItem?
    @Binding var isShowingItemDetail: Bool
    @Binding var isShowingTransactionDetail: Bool
    
    let usedItem: SimpleUsedItem
    
    var body: some View {
        VStack(spacing: 0) {
            ItemInfoRow(item: usedItem.item)
                .padding(20)
            
            Divider()
                .padding(.bottom)
            
            HStack {
                Button {
                    selectedItem = usedItem
                    isShowingItemDetail.toggle()
                } label: {
                    Text("물품 상세")
                        .font(.subheadline)
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderless)
                
                Divider()
                    .frame(height: 20)
                
                Button {
//                    selectedItem = usedItem
//                    isShowingTransactionDetail.toggle()
                    isShowingAlert.toggle()
                } label: {
                    Text("거래 상세")
                        .font(.subheadline)
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderless)
            }
            .padding(.bottom)
            
            SectionFooter()
        }
        .alert(isPresented: $isShowingAlert) {
            Alert(title: Text("알림"), message: Text("준비중"))
        }
    }
}

#if DEBUG
#Preview {
    SoldItemListRow(selectedItem: .constant(nil), 
                    isShowingItemDetail: .constant(false),
                    isShowingTransactionDetail: .constant(false),
                    usedItem: SimpleUsedItem.sampleData)
}
#endif
