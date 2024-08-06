//
//  EditButtonLabel.swift
//  Baobab
//
//  Created by 이정훈 on 7/21/24.
//

import SwiftUI

struct EditButtonLabel: View {
    var body: some View {
        HStack(spacing: 5) {
            Image(systemName: "pencil")
            
            Text("방문지 변경 및 추가")
        }
        .bold()
        .font(.footnote)
        .padding()
        .overlay {
            RoundedRectangle(cornerRadius: 5)
                .stroke()
        }
    }
}

#Preview {
    EditButtonLabel()
}
