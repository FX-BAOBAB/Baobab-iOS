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
    @State private var buttonDisable: Bool = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        List {
            Button {
                buttonDisable.toggle()
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
                .disabled(buttonDisable)
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
    }
}

#Preview {
    NavigationStack {
        LaboratoryList()
    }
}
