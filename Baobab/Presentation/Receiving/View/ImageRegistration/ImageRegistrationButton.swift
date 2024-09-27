//
//  ImageRegistrationButton.swift
//  Baobab
//
//  Created by 이정훈 on 9/25/24.
//

import SwiftUI
import RealityKit

struct ImageRegistrationButton: View {
    @EnvironmentObject private var viewModel: ReceivingViewModel
    @State private var isShowingARPreview: Bool = false
    @State private var isShowingDefectRegistration: Bool = false
    @State private var isShowingObjectCaptureView: Bool = false
    @Binding var isShowingReceivingForm: Bool
    
    var body: some View {
        Button {
            #if targetEnvironment(simulator)
                isShowingDefectRegistration.toggle()
            #else
            if #available(iOS 17, *), ObjectCaptureSession.isSupported {
                isShowingARPreview.toggle()
            } else {
                isShowingDefectRegistration.toggle()
            }
            #endif
            
        } label: {
            Text("다음")
                .bold()
                .frame(maxWidth: .infinity)
                .padding(8)
        }
        .buttonBorderShape(.roundedRectangle)
        .cornerRadius(10)
        .buttonStyle(.borderedProminent)
        .fullScreenCover(isPresented: $isShowingARPreview) {
            NavigationStack {
                BaobabARPreview(isShowingARPreview: $isShowingARPreview,
                          isShowingDefectRegistration: $isShowingDefectRegistration,
                          isShowingCaptureView: $isShowingObjectCaptureView)
            }
        }
        .fullScreenCover(isPresented: $isShowingObjectCaptureView) {
            if #available(iOS 17, *) {
                NavigationStack {
                    #if !targetEnvironment(simulator)
                    CapturePrimaryView(viewModel: AppDI.shared.makeObjectCaptureViewModel(),
                                       isShowingObjectCaptureView: $isShowingObjectCaptureView)
                    #else
                    EmptyView()
                    #endif
                }
            }
        }
        .navigationDestination(isPresented: $isShowingDefectRegistration) {
            DefectRegistrationList(isShowingReceivingForm: $isShowingReceivingForm)
                .environmentObject(viewModel)
        }
    }
}

#Preview {
    ImageRegistrationButton(isShowingReceivingForm: .constant(true))
        .environmentObject(AppDI.shared.makeReceivingViewModel())
}
