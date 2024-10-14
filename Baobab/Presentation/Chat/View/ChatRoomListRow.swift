//
//  ChatRoomListRow.swift
//  Baobab
//
//  Created by 이정훈 on 10/10/24.
//

import SwiftUI

struct ChatRoomListRow: View {
    let chatRoom: ChatRoom
    
    var body: some View {
        HStack {
            Text("\(chatRoom.id)번 채팅방")
            
            Spacer()
        }
        .padding([.top, .bottom])
    }
}

#if DEBUG
#Preview {
    ChatRoomListRow(chatRoom: ChatRoom.example)
}
#endif
