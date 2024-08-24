//
//  CancelButtonLabel.swift
//  Baobab
//
//  Created by 이정훈 on 8/24/24.
//

import SwiftUI

struct CancelButtonLabel: View {
    let title: String
    
    var body: some View {
        HStack(spacing: 5) {
            Image(systemName: "xmark")
            
            Text(title)
        }
        .bold()
        .frame(maxWidth: .infinity)
        .foregroundStyle(.white)
        .padding()
        .background(Color(red: 52 / 255, green: 58 / 255, blue: 64 / 255))
        .cornerRadius(10)
    }
}

#Preview {
    CancelButtonLabel(title: "취소")
}
