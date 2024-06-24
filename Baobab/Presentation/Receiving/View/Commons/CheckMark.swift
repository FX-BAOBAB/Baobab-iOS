//
//  CheckMark.swift
//  Baobab
//
//  Created by 이정훈 on 5/13/24.
//

import SwiftUI

struct CheckMark: View {
    var body: some View {
        Circle()
            .fill(.blue)
            .frame(width: 20)
            .overlay {
                Image(systemName: "checkmark")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 10)
                    .foregroundColor(.white)
            }
    }
}

#Preview {
    CheckMark()
}
