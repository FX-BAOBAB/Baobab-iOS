//
//  IntermediateView.swift
//  Baobab
//
//  Created by 이정훈 on 9/2/24.
//

import SwiftUI
import RealityKit

#if !targetEnvironment(simulator)
@available(iOS 17, *)
struct IntermediateScanView: View {
    @EnvironmentObject private var viewModel: ObjectCaptureViewModel
    @Binding var isShowingSheet: Bool
    @Binding var isShowingReconstructionView: Bool
    
    var body: some View {
        VStack {
            if let session = viewModel.objectCaptureSession {
                ObjectCapturePointCloudView(session: session)
            }
            
            Spacer()
            
            Text("You can achieve better results by scanning multiple times.")
                .font(.subheadline)
            
            Button {
                isShowingSheet.toggle()
                viewModel.objectCaptureSession?.beginNewScanPass()
            } label: {
                Text("Continue")
                    .bold()
                    .padding(10)
            }
            .buttonStyle(.borderedProminent)
            .padding()
            
            Button {
                viewModel.objectCaptureSession?.finish()
                isShowingSheet.toggle()
                isShowingReconstructionView.toggle()
            } label: {
                Text("Finish")
                    .underline()
            }
        }
        .padding()
    }
}

#Preview {
    if #available(iOS 17, *) {
        IntermediateScanView(isShowingSheet: .constant(true),
                             isShowingReconstructionView: .constant(true))
            .environmentObject(AppDI.shared.makeObjectCaptureViewModel())
    } else {
        EmptyView()
    }
}
#endif
