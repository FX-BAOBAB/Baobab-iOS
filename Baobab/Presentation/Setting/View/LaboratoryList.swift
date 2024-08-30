//
//  Laboratory.swift
//  Baobab
//
//  Created by 이정훈 on 8/28/24.
//

import RealityKit
import SwiftUI

struct LaboratoryList: View {
    @State private var isShowingObjectCaptureView: Bool = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        List {
            Button {
                isShowingObjectCaptureView.toggle()
            } label: {
                HStack {
                    Text("Object Capture")
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                        .bold()
                }
                .padding([.top, .bottom])
            }
        }
        .listStyle(.plain)
        .navigationTitle("실험실")
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
        .fullScreenCover(isPresented: $isShowingObjectCaptureView) {
            NavigationStack {
                #if targetEnvironment(simulator)
                NoAvailableView(isShowingFullScreenCover: $isShowingObjectCaptureView)
                #else
                if #available(iOS 17, *), ObjectCaptureSession.isSupported {
                    CapturePrimaryView(isShowingObjectCaptureView: $isShowingObjectCaptureView)
                } else {
                    NoAvailableView(isShowingFullScreenCover: $isShowingObjectCaptureView)
                }
                #endif
            }
        }
    }
}

#Preview {
    NavigationStack {
        LaboratoryList()
    }
}
