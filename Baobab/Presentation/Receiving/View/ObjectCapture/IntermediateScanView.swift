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
            
            Text("여러 번 촬영하면 더 나은 결과를 얻을 수 있습니다.")
                .font(.subheadline)
            
            Button {
                isShowingSheet.toggle()
                viewModel.objectCaptureSession?.beginNewScanPass()
            } label: {
                Text("추가 촬영 진행하기")
                    .bold()
                    .padding(10)
            }
            .buttonStyle(.borderedProminent)
            .padding()
            
            Button {
                viewModel.objectCaptureSession?.finish()
                viewModel.objectCaptureSession = nil
                isShowingSheet.toggle()
                isShowingReconstructionView.toggle()
            } label: {
                Text("완료하기")
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
