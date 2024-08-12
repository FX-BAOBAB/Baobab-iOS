//
//  PlusButtonImage.swift
//  Baobab
//
//  Created by 이정훈 on 5/10/24.
//

import SwiftUI

struct PlusButtonImage: View {
    var body: some View {
        Circle()
            .fill(.gray)
            .frame(width: 20)
            .overlay {
                Image(systemName: "plus")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
                    .frame(width: 10)
            }
    }
}

#Preview {
    PlusButtonImage()
}
