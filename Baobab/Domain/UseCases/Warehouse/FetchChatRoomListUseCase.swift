//
//  FetchChatRoomListUseCase.swift
//  Baobab
//
//  Created by 이정훈 on 10/10/24.
//

import Combine

protocol FetchChatRoomListUseCase {
    func execute() -> AnyPublisher<[ChatRoom], any Error>
}

final class FetchChatRoomListUseCaseImpl: FetchChatRoomListUseCase {
    private let repository: ChatRoomRepository
    
    init(repository: ChatRoomRepository) {
        self.repository = repository
    }
    
    func execute() -> AnyPublisher<[ChatRoom], any Error> {
        return repository.fetchChatRooms()
    }
}
