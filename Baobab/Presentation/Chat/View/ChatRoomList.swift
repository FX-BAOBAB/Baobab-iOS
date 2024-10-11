//
//  ChatRoomList.swift
//  Baobab
//
//  Created by 이정훈 on 10/10/24.
//

import SwiftUI

struct ChatRoomList: View {
    @StateObject private var viewModel: ChatRoomListViewModel
    @Environment(\.dismiss) private var dismiss
    
    init(viewModel: ChatRoomListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        Group {
            if let chatRooms = viewModel.chatRooms {
                if !chatRooms.isEmpty {
                    List {
                        ForEach(chatRooms) { chatRoom in
                            ChatRoomListRow(chatRoom: chatRoom)
                        }
                    }
                    .listStyle(.plain)
                } else {
                    Text("채팅방이 없어요.")
                }
            } else if viewModel.isLoading {
                CustomProgressView()
            } else {
                Color.clear
                    .onAppear {
                        viewModel.fetchChatRooms()
                    }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("채팅")
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ChatRoomList(viewModel: AppDI.shared.makeChatRoomListViewModel())
    }
}
