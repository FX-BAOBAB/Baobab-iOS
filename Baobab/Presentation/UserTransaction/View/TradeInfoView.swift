//
//  TraderInfoView.swift
//  Baobab
//
//  Created by 이정훈 on 9/16/24.
//

import SwiftUI

struct TradeInfoView: View {
    let history: TransactionHistory
    
    var body: some View {
        HStack(alignment: .top, spacing: 40) {
            VStack(alignment: .leading, spacing: 20) {
                Text("물품 번호")
                
                Text("거래 번호")
                
                Text("구매자")
                
                Text("판매자")
                
                Text("거래 일시")
            }
            .foregroundStyle(.gray)
            
            VStack(alignment: .leading, spacing: 20) {
                Text("\(history.usedGoodsID)")
                
                Text("\(history.usedGoodsOrderID)")
                
                Text(history.buyer.name)
                
                Text(history.seller.name)
                
                Text(Date.toSimpleFormat(from: history.createdAt, format: .full))
            }
        }
        .font(.subheadline)
    }
}

#if DEBUG
#Preview {
    TradeInfoView(history: TransactionHistory.sampleData)
}
#endif
