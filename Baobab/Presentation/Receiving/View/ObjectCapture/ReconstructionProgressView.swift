//
//  ReconstructionProgressView.swift
//  Baobab
//
//  Created by 이정훈 on 8/30/24.
//

import SwiftUI
import QuickLook
@preconcurrency import RealityKit

#if !targetEnvironment(simulator)
@available(iOS 17, *)
struct ReconstructionProgressView: View {
    @EnvironmentObject private var viewModel: ObjectCaptureViewModel
    @Binding var isShowingObjectCaptureView: Bool
    
    var body: some View {
        VStack {
            Text("3D 모델을 생성하는 중입니다...")
                .bold()
                .font(.title)
                .padding()
            
            ProgressBarView(estimatedRemainingTime: $viewModel.estimatedRemainingTime,
                            requestProcessPercentage: $viewModel.requestProcessPercentage)
        }
        .navigationBarBackButtonHidden()
        .padding()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    viewModel.reset()
                    viewModel.deleteModelFile()
                    isShowingObjectCaptureView.toggle()
                } label: {
                    Text("취소")
                }
                .buttonStyle(.bordered)
            }
        }
        .task {
            do {
                try viewModel.startReconstruction()
                
                guard let session = viewModel.photogrammetrySession else { return }
                
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
                    case .requestProgressInfo(let request, let progressInfo):
                        if case .modelFile = request {
                            viewModel.handleRequestProgressInfo(progressInfo)
                        }
                    default:
                        print("Unkown Error")
                    }
                }
            } catch {
                print("\(error)")
            }
        }
        .quickLookPreview($viewModel.output)
    }
}

#Preview {
    if #available(iOS 17.0, *) {
        ReconstructionProgressView(isShowingObjectCaptureView: .constant(true))
            .environmentObject(AppDI.shared.makeObjectCaptureViewModel())
    } else {
        EmptyView()
    }
}
#endif