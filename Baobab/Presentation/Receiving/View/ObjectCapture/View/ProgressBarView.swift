//
//  ProgressBarView.swift
//  Baobab
//
//  Created by 이정훈 on 9/29/24.
//

import SwiftUI

struct ProgressBarView: View {
    @Binding var estimatedRemainingTime: TimeInterval?
    @Binding var requestProcessPercentage: Double
    
    private var formattedRemainingTime: String? {
        guard let estimatedRemainingTime else { return nil }
        
        let formatter = DateComponentsFormatter()
        formatter.zeroFormattingBehavior = .pad
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.minute, .second]
        return formatter.string(from: estimatedRemainingTime)
    }
    
    var body: some View {
        ProgressView(value: requestProcessPercentage) {
            HStack {
                Text("\(Int(requestProcessPercentage * 100))% 완료")
                
                Spacer()
                
                if let formattedRemainingTime {
                    Text("남은시간: \(formattedRemainingTime)")
                }
            }
            .font(.footnote)
        }
        .progressViewStyle(.linear)
    }
}

#Preview {
    ProgressBarView(estimatedRemainingTime: .constant(TimeInterval(59)),
                    requestProcessPercentage: .constant(0.77))
}
