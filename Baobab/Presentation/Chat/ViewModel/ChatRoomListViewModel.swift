//
//  ChatRoomListViewModel.swift
//  Baobab
//
//  Created by 이정훈 on 10/10/24.
//

import Combine
import os

final class ChatRoomListViewModel: ObservableObject {
    @Published var chatRooms: [ChatRoom]?
    @Published var isLoading: Bool = false
    
    private let usecase: FetchChatRoomListUseCase
    private var cancellables: Set<AnyCancellable> = []
    private let logger = Logger(subsystem: "Baobab", category: "ChatRoomListViewModel")
    
    init(usecase: FetchChatRoomListUseCase) {
        self.usecase = usecase
    }
    
    func fetchChatRooms() {
        isLoading.toggle()
        
        usecase.execute()
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading.toggle()
                
                switch completion {
                case .finished:
                    self?.logger.info("The request to fetch chat rooms has been completed.")
                case .failure(let error):
                    self?.logger.info("The request to fetch chat rooms has failed with error: \(error)")
                }
            }, receiveValue: { [weak self] in
                self?.chatRooms = $0
            })
            .store(in: &cancellables)
    }
}
