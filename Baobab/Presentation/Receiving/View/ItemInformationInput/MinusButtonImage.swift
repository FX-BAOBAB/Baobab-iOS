//
//  MinusButtonImage.swift
//  Baobab
//
//  Created by 이정훈 on 5/10/24.
//

import SwiftUI

struct MinusButtonImage: View {
    var body: some View {
        Circle()
            .fill(.gray)
            .frame(width: 15)
            .overlay {
                Image(systemName: "minus")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 8)
                    .foregroundColor(.white)
            }
    }
}

#Preview {
    MinusButtonImage()
}
