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
    @State private var isChatActive: Bool = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        List {
            HStack {
                Toggle(isOn: Binding(get: {
                    isChatActive
                }, set: {
                    isChatActive = $0
                    UserDefaults.standard.set($0, forKey: "chat")
                })) {
                    Text("채팅")
                }
                .tint(.accentColor)
            }
            .padding([.top, .bottom])
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
        .onAppear {
            isChatActive = UserDefaults.standard.bool(forKey: "chat")
        }
    }
}

#Preview {
    NavigationStack {
        LaboratoryList()
    }
}
