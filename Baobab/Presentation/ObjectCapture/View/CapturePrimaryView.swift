//
//  CapturePrimaryView.swift
//  Baobab
//
//  Created by 이정훈 on 8/28/24.
//

import RealityKit
import SwiftUI

#if !targetEnvironment(simulator)
@MainActor
@available(iOS 17, *)
struct CapturePrimaryView: View {
    @State private var session = ObjectCaptureSession()
    @State private var isShowingReconstructionView: Bool = false
    @Binding var isShowingObjectCaptureView: Bool
    
    var body: some View {
        Group {
            if session.userCompletedScanPass {
                ZStack {
                    VStack {
                        Image("verify")
                        
                        Text("Finish Captures.")
                    }
                    
                    CreateButton(label: "Next") {
                        session.finish()
                        isShowingReconstructionView.toggle()
                    }
                }
            } else {
                ZStack {
                    ObjectCaptureView(session: session)
                    
                    if case .ready = session.state {
                        CreateButton(label: "Continue") {
                            let _ = session.startDetecting()
                        }
                    } else if case .detecting = session.state {
                        CreateButton(label: "Start Capture") {
                            session.startCapturing()
                        }
                    } else if case .failed(_) = session.state {
                        //Bottom View for failing
                    }
                }
            }
            
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    isShowingObjectCaptureView.toggle()
                } label: {
                    Text("Cancel")
                }
                .buttonStyle(.bordered)
            }
        }
        .onAppear {
            var configuration = ObjectCaptureSession.Configuration()
            configuration.checkpointDirectory = getDocumentsDir().appendingPathComponent("Snapshots/")
            
            session.start(imagesDirectory: getDocumentsDir().appendingPathComponent("Images/"),
                          configuration: configuration)
        }
        .navigationDestination(isPresented: $isShowingReconstructionView) {
            ReconstructionProgressView(viewModel: AppDI.shared.makeObjectCaptureViewModel(),
                                       session: $session, 
                                       isShowingObjectCaptureView: $isShowingObjectCaptureView)
        }
    }
}

#Preview {
    if #available(iOS 17, *) {
        CapturePrimaryView(isShowingObjectCaptureView: .constant(true))
    } else {
        EmptyView()
    }
}
#endif
