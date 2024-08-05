//
//  StatusLabel.swift
//  Baobab
//
//  Created by 이정훈 on 7/26/24.
//

import SwiftUI

struct StatusLabel: View {
    let status: ItemStatus
    
    var body: some View {
        Group {
            switch status {
            case .receiving:
                Text("입고 중")
                    .padding(5)
                    .foregroundStyle(.white)
                    .background(.orange)
            case .stored:
                Text("입고 됨")
                    .padding(5)
                    .foregroundStyle(.white)
                    .background(.orange)
            case .returned:
                Text("반품 됨")
                    .padding(5)
                    .foregroundStyle(.white)
                    .background(.green)
            case .returning:
                Text("반품 중")
                    .padding(5)
                    .foregroundStyle(.white)
                    .background(.orange)
            case .shipping:
                Text("출고 중")
                    .padding(5)
                    .foregroundStyle(.white)
                    .background(.orange)
            case .shipped:
                Text("출고 됨")
                    .padding(5)
                    .foregroundStyle(.white)
                    .background(.green)
            case .used:
                Text("중고 전환 됨")
                    .padding(5)
                    .foregroundStyle(.white)
                    .background(.orange)
            }
        }
        .bold()
        .font(.caption2)
        .cornerRadius(5)
    }
}

#Preview {
    StatusLabel(status: .receiving)
}
