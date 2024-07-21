//
//  SignUpCaption.swift
//  Baobab
//
//  Created by 이정훈 on 6/28/24.
//

import SwiftUI

struct SignUpCaption: View {
    let caption: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 3) {
            Image(systemName: "info.circle")
            
            Text(caption)
        }
        .font(.caption2)
        .foregroundColor(color)
        .frame(maxWidth: .infinity, alignment: .leading)
        .offset(x: 5)
    }
}

#Preview {
    SignUpCaption(caption: "warning", color: .red)
}
