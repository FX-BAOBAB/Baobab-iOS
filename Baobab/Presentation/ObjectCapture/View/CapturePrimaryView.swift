//
//  CapturePrimaryView.swift
//  Baobab
//
//  Created by 이정훈 on 8/28/24.
//

import SwiftUI
import RealityKit

#if !targetEnvironment(simulator)
@available(iOS 17, *)
struct CapturePrimaryView: View {
    @StateObject private var viewModel: ObjectCaptureViewModel
    @State private var isShowingReconstructionView: Bool = false
    @State private var isShowingSheet: Bool = false
    @Binding var isShowingObjectCaptureView: Bool
    
    init(viewModel: ObjectCaptureViewModel,
         isShowingObjectCaptureView: Binding<Bool>) {
        _viewModel = StateObject(wrappedValue: viewModel)
        _isShowingObjectCaptureView = isShowingObjectCaptureView
    }
    
    var body: some View {
        ZStack {
            if let session = viewModel.objectCaptureSession {
                ObjectCaptureView(session: session)
                
                if case .normal = viewModel.objectCaptureSession?.cameraTracking {
                    if case .ready = session.state {
                        CreateButton(label: "Continue") {
                            let _ = session.startDetecting()
                        }
                    } else if case .detecting = session.state {
                        CreateButton(label: "Start Capture") {
                            session.startCapturing()
                        }
                    }
                }
            }
        }
        .toolbarBackground(.hidden, for: .navigationBar)
        .toolbar {
            if case .normal = viewModel.objectCaptureSession?.cameraTracking {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        viewModel.objectCaptureSession?.cancel()
                        viewModel.reset()
                        isShowingObjectCaptureView.toggle()
                    } label: {
                        Text("Cancel")
                    }
                    .buttonStyle(.bordered)
                }
            }
        }
        .task {
            //ObjectCaptureSession 초기화
            viewModel.startNewCapture()
        }
        .navigationDestination(isPresented: $isShowingReconstructionView) {
            LazyView {
                ReconstructionProgressView(isShowingObjectCaptureView: $isShowingObjectCaptureView)
                    .environmentObject(viewModel)
            }
        }
        .onChange(of: viewModel.objectCaptureSession?.userCompletedScanPass) {
            if viewModel.objectCaptureSession?.userCompletedScanPass == true {
                isShowingSheet.toggle()
            }
        }
        .onChange(of: viewModel.objectCaptureSession?.state) {
            if case .failed(let error) = viewModel.objectCaptureSession?.state {
                print(error)
                viewModel.startNewCapture()
            }
        }
        .sheet(isPresented: $isShowingSheet) {
            IntermediateScanView(isShowingSheet: $isShowingSheet, 
                                 isShowingReconstructionView: $isShowingReconstructionView)
            .environmentObject(viewModel)
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
