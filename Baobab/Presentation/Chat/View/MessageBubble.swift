//
//  MessageBubble.swift
//  Baobab
//
//  Created by 이정훈 on 10/11/24.
//

import SwiftUI

struct MessageBubble: View {
    enum UserType {
        case sender, receiver
    }
    
    let message: String
    let userType: UserType
    
    var body: some View {
        Text(message)
            .font(.subheadline)
            .foregroundStyle(userType == .sender ? .white : .black)
            .padding(10)
            .background(userType == .sender ? .accent : .receiverBubble)
            .clipShape(
                .rect(
                    topLeadingRadius: userType == .sender ? 15 : 0,
                    bottomLeadingRadius: 15,
                    bottomTrailingRadius: 15,
                    topTrailingRadius: userType == .sender ? 0 : 15
                )
            )
    }
}

#Preview {
    MessageBubble(message: "테스트입니다.", userType: .receiver)
}
