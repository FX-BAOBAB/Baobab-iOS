//
//  DefaultItemImage.swift
//  Baobab
//
//  Created by 이정훈 on 6/25/24.
//

import SwiftUI

struct DefaultItemImage: View {
    var body: some View {
        
        RoundedRectangle(cornerRadius: 10)
            .foregroundColor(.gray)
            .frame(width: UIScreen.main.bounds.width * 0.15,
                   height: UIScreen.main.bounds.width * 0.15)
            .overlay {
                Image(systemName: "exclamationmark.triangle.fill")
                    .resizable()
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width * 0.05,
                           height: UIScreen.main.bounds.width * 0.05)
            }
    }
}

#Preview {
    DefaultItemImage()
}
