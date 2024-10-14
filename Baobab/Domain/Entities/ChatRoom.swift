//
//  ChatRoom.swift
//  Baobab
//
//  Created by 이정훈 on 10/10/24.
//

import Foundation

struct ChatRoom: Identifiable {
    let id: Int
    let usedGoodsId: Int
    let status: String
    let createdAt: String
}

#if DEBUG
extension ChatRoom {
    static var example: Self {
        .init(id: 1, usedGoodsId: 1, status: "", createdAt: "")
    }
}
#endif
