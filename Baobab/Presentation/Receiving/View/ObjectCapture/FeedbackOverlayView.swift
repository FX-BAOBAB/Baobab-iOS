//
//  FeedbackOverlayView.swift
//  Baobab
//
//  Created by 이정훈 on 9/27/24.
//

import SwiftUI

#if !targetEnvironment(simulator)
@available(iOS 17, *)
struct FeedbackOverlayView: View {
    @EnvironmentObject private var viewModel: ObjectCaptureViewModel
    @State private var feedback: String?
    
    var body: some View {
        Group {
            if let feedback {
                Text(feedback)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .transition(.opacity)
            }
        }
        .onChange(of: viewModel.feedbackMessage) {
            withAnimation {
                feedback = viewModel.feedbackMessage
            }
        }
    }
}

#Preview {
    if #available(iOS 17, *) {
        FeedbackOverlayView()
            .environmentObject(AppDI.shared.makeObjectCaptureViewModel())
    } else {
        // Fallback on earlier versions
        EmptyView()
    }
}
#endif
