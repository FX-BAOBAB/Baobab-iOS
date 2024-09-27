//
//  NoAvailableView.swift
//  Baobab
//
//  Created by 이정훈 on 8/28/24.
//

import SwiftUI

struct NoAvailableView: View {
    @Binding var isShowingFullScreenCover: Bool
    
    var body: some View {
        Text("해당 기종은 지원하지 않습니다.")
            .navigationTitle("Object Capture")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isShowingFullScreenCover.toggle()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(.black)
                    }
                }
            }
    }
}

#Preview {
    NavigationStack {
        NoAvailableView(isShowingFullScreenCover: .constant(true))
    }
}
