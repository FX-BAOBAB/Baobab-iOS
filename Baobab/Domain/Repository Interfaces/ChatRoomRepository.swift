//
//  ChatRoomRepository.swift
//  Baobab
//
//  Created by 이정훈 on 10/10/24.
//

import Combine

protocol ChatRoomRepository {
    func fetchChatRooms() -> AnyPublisher<[ChatRoom], any Error>
}
