//
//  ChatRoomViewModel.swift
//  Baobab
//
//  Created by 이정훈 on 10/10/24.
//

import Combine

final class ChatRoomViewModel: ObservableObject {
    @Published var inputMessage: String = ""
}
