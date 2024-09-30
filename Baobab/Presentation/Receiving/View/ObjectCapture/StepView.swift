//
//  StepView.swift
//  Baobab
//
//  Created by 이정훈 on 8/30/24.
//

import SwiftUI

struct StepView: View {
    enum Step {
        case one, two
    }
    
    let step: Step
    
    var body: some View {
        switch step {
        case .one:
            VStack(spacing: 30) {
                HStack {
                    Image(systemName: "1.circle.fill")
                    
                    Image(systemName: "2.circle")
                }
                .foregroundStyle(.gray)
                
                Text("First Segment Completed")
                    .font(.title)
                    .bold()
                
                Spacer()
            }
        case .two:
            VStack(spacing: 30) {
                HStack {
                    Image(systemName: "1.circle.fill")
                    
                    Image(systemName: "2.circle.fill")
                }
                .foregroundStyle(.gray)
                
                Text("All Segments Complete.")
                    .font(.title)
                    .bold()
                
                Spacer()
            }
        }
    }
}

#Preview {
    StepView(step: .two)
}
