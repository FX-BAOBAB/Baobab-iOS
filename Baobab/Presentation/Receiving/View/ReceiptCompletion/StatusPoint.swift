//
//  StatusPoint.swift
//  Baobab
//
//  Created by 이정훈 on 6/25/24.
//

import SwiftUI

struct StatusPoint: View {
    let stage: String
    let isAccent: Bool
    
    var body: some View {
        VStack {
            if isAccent {
                Image(systemName: "truck.box.fill")
            }
            
            ZStack {
                Circle()
                    .frame(width: 20)
                
                Circle()
                    .fill(isAccent ? .blue : .white)
                    .frame(width: 16)
            }
            
            Text(stage)
                .font(.caption2)
        }
        .offset(y: isAccent ? -3 : 8)
    }
}

#Preview {
    StatusPoint(stage: "입고신청완료", isAccent: true)
}
