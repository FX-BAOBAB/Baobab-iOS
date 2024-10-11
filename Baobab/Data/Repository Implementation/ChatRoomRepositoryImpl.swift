//
//  ChatRoomRepositoryImpl.swift
//  Baobab
//
//  Created by 이정훈 on 10/10/24.
//

import Combine
import Foundation

final class ChatRoomRepositoryImpl: RemoteRepository, ChatRoomRepository {
    func fetchChatRooms() -> AnyPublisher<[ChatRoom], Error> {
        let apiEndPoint = Bundle.main.warehouseURL + "/chat/rooms"
        
        return dataSource.sendGetRequest(to: apiEndPoint, resultType: ChatRoomResponseDTO.self)
            .map { dto in
                dto.body.map {
                    ChatRoom(id: $0.chatRoomID,
                             usedGoodsId: $0.usedGoodsID,
                             status: $0.status,
                             createdAt: $0.createdAt)
                }
            }
            .eraseToAnyPublisher()
    }
}
