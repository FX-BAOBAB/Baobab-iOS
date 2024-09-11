//
//  TitleOverlay.swift
//  Baobab
//
//  Created by 이정훈 on 9/10/24.
//

import SwiftUI

struct TitleOverlay: View {
    let title: String
    
    var body: some View {
        Text(title)
            .lineLimit(1)
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.caption)
            .bold()
            .foregroundStyle(.white)
            .padding(10)
            .background {
                Rectangle()
                    .opacity(0.5)
            }
    }
}

#Preview {
    TitleOverlay(title: "테스트입니다.")
}
