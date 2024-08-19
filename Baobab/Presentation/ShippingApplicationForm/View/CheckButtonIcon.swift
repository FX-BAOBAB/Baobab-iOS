//
//  CheckButtonIcon.swift
//  Baobab
//
//  Created by 이정훈 on 8/15/24.
//

import SwiftUI

struct CheckButtonIcon: View {
    let checked: Bool
    
    var body: some View {
        if checked {
            Circle()
                .frame(width: 20)
                .foregroundStyle(.accent)
                .overlay {
                    Image(systemName: "checkmark")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 10)
                        .foregroundStyle(.white)
                        .bold()
                }
        } else {
            Circle()
                .stroke(.gray, lineWidth: 2)
                .frame(width: 20)
        }
    }
}

#Preview {
    CheckButtonIcon(checked: true)
}
