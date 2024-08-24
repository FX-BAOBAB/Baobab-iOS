//
//  ConfirmationButtonLabel.swift
//  Baobab
//
//  Created by 이정훈 on 8/24/24.
//

import SwiftUI

struct ConfirmationButtonLabel: View {
    let title: String
    
    var body: some View {
        HStack(spacing: 8) {
            Image("CheckCircle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20)
            
            Text(title)
        }
        .bold()
        .frame(maxWidth: .infinity)
        .foregroundStyle(.white)
        .padding()
        .background(.accent)
        .cornerRadius(10)
    }
}

#Preview {
    ConfirmationButtonLabel(title: "확인")
}
