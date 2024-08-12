//
//  EmptyItemView.swift
//  Baobab
//
//  Created by 이정훈 on 8/12/24.
//

import SwiftUI

struct EmptyItemView: View {
    var body: some View {
        ZStack {
            Color.listFooterGray
            
            VStack(spacing: 30) {
                Image(systemName: "shippingbox.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width * 0.25)
                    .foregroundStyle(.gray)
                
                Text("물품이 존재하지 않아요 :(")
                    .foregroundStyle(.gray)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    EmptyItemView()
}
