//
//  ReconstructionProgressView.swift
//  Baobab
//
//  Created by 이정훈 on 8/30/24.
//

import RealityKit
import SwiftUI
import QuickLook

#if !targetEnvironment(simulator)
@available(iOS 17, *)
struct ReconstructionProgressView: View {
    @StateObject private var viewModel: ObjectCaptureViewModel
    @Binding var session: ObjectCaptureSession
    @Binding var isShowingObjectCaptureView: Bool
    
    init(viewModel: ObjectCaptureViewModel, 
         session: Binding<ObjectCaptureSession>,
         isShowingObjectCaptureView: Binding<Bool>
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        _session = session
        _isShowingObjectCaptureView = isShowingObjectCaptureView
    }
    
    var body: some View {
        VStack {
            ObjectCapturePointCloudView(session: session)
            
            ProgressView(value: viewModel.requestProcessPercentage) {
                Text("\(viewModel.requestProcessPercentage * 100)% progress")
            }
            .progressViewStyle(.linear)
        }
        .navigationBarBackButtonHidden()
        .padding()
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
        .task {
            do {
                var configuration = PhotogrammetrySession.Configuration()
                configuration.checkpointDirectory = getDocumentsDir().appendingPathComponent("Snapshots/")
                let session = try PhotogrammetrySession(
                    input: getDocumentsDir().appendingPathComponent("Images/"),
                    configuration: configuration
                )
                try session.process(requests: [
                    .modelFile(url: getDocumentsDir().appendingPathComponent("model.usdz"))
                ])
                
                for try await output in session.outputs {
                    switch output {
                    case .processingComplete:
                        self.viewModel.handleProcessingComplete()
                    case .inputComplete:
                        print("Input Complete.")
                    case .requestError(let request, let error):
                        print("Request Error: \(request) : \(error)")
                    case .requestComplete(let request, let result):
                        print("Request Complete: \(request) : \(result)")
                    case .requestProgress(_, fractionComplete: let fractionComplete):
                        self.viewModel.handleRequestProcess(fractionComplete)
                    case .processingCancelled:
                        print("Processing Cancelled!")
                    case .invalidSample(id: let id, reason: let reason):
                        print("Invalid Sample \(id) : \(reason)")
                    case .skippedSample(id: let id):
                        print("Skipped Sample: \(id)")
                    case .automaticDownsampling:
                        print("AutomaticDownsampling")
                    case .requestProgressInfo( _, let progressInfo):
                        self.viewModel.handleRequestProgressInfo(progressInfo.processingStage)
                    default:
                        print("Unkown Error")
                    }
                }
            } catch {
                print("\(error)")
            }
        }
        .quickLookPreview($viewModel.output)
        .onDisappear {
            viewModel.deleteModelFile()
        }
    }
}

#Preview {
    if #available(iOS 17.0, *) {
        ReconstructionProgressView(viewModel: AppDI.shared.makeObjectCaptureViewModel(),
                                   session: .constant(ObjectCaptureSession()), 
                                   isShowingObjectCaptureView: .constant(true))
    } else {
        EmptyView()
    }
}
#endif
