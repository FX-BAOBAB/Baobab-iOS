//
//  ReceivingStatus.swift
//  Baobab
//
//  Created by 이정훈 on 6/25/24.
//

import SwiftUI

struct SimpleReceivingStatus: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .fill(.gray)
                .frame(width: UIScreen.main.bounds.width - 60, height: 3)
                .offset(x: 5)
            
            HStack {
                StatusPoint(stage: "입고접수", isAccent: true)
                
                Spacer()
                
                StatusPoint(stage: "입고심의", isAccent: false)
                
                Spacer()
                
                StatusPoint(stage: "배송중", isAccent: false)
                
                Spacer()
                
                StatusPoint(stage: "입고", isAccent: false)
            }
        }
    }
}

#Preview {
    SimpleReceivingStatus()
}
