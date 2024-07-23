//
//  UserInfoListRow.swift
//  Baobab
//
//  Created by 이정훈 on 7/23/24.
//

import SwiftUI

struct UserInfoListRow: View {
    let image: String
    let title: String
    
    var body: some View {
        HStack {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 35, height: 35)
            
            Text(title)
                .font(.subheadline)
        }
        .padding([.top, .bottom], 5)
    }
}

#Preview {
    UserInfoListRow(image: "receiving", title: "입고 요청서")
}
