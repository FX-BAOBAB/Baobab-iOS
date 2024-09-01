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
    @StateObject private var viewModel: ObjectCaptureViewModel
    @State private var isShowingReconstructionView: Bool = false
    @Binding var isShowingObjectCaptureView: Bool
    
    init(viewModel: ObjectCaptureViewModel,
         isShowingObjectCaptureView: Binding<Bool>) {
        _viewModel = StateObject(wrappedValue: viewModel)
        _isShowingObjectCaptureView = isShowingObjectCaptureView
    }
    
    var body: some View {
        ZStack {
            if let session = viewModel.session {
                ObjectCaptureView(session: session)
                
                if case .ready = session.state {
                    CreateButton(label: "Continue") {
                        let _ = session.startDetecting()
                    }
                } else if case .detecting = session.state {
                    CreateButton(label: "Start Capture") {
                        session.startCapturing()
                    }
                } else if case .capturing = session.state {
                    if session.userCompletedScanPass {
                        HStack {
                            CreateButton(label: "Continue") {
                                session.beginNewScanPass()    //capturing 상태가 아닐때 호출시 에러
                            }
                            
                            CreateButton(label: "Finish") {
                                session.finish()
                                isShowingReconstructionView.toggle()
                            }
                        }
                    }
                } else if case .failed(_) = session.state {
                    //Bottom View for failing
                    CreateButton(label: "Done") {
                        session.cancel()
                        isShowingReconstructionView.toggle()
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    viewModel.cleanup()
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
            
            viewModel.session = ObjectCaptureSession()
            viewModel.session?.start(imagesDirectory: getDocumentsDir().appendingPathComponent("Images/"),
                          configuration: configuration)
        }
        .navigationDestination(isPresented: $isShowingReconstructionView) {
            LazyView {
                ReconstructionProgressView(isShowingObjectCaptureView: $isShowingObjectCaptureView)
                    .environmentObject(viewModel)
            }
        }
    }
}

#Preview {
    if #available(iOS 17, *) {
        CapturePrimaryView(viewModel: AppDI.shared.makeObjectCaptureViewModel(),
                           isShowingObjectCaptureView: .constant(true))
    } else {
        EmptyView()
    }
}
#endif
