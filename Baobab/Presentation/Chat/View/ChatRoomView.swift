//
//  ChatRoomView.swift
//  Baobab
//
//  Created by 이정훈 on 10/10/24.
//

import SwiftUI

struct ChatRoomView: View {
    @StateObject private var viewModel: ChatRoomViewModel
    @Environment(\.dismiss) private var dismiss
    
    init(viewModel: ChatRoomViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                LazyVStack {
                    
                }
            }
            
            MessageInputView()
                .environmentObject(viewModel)
                .padding([.leading, .trailing, .bottom])
        }
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

fileprivate struct MessageInputView: View {
    @EnvironmentObject private var viewModel: ChatRoomViewModel
    
    var body: some View {
        HStack {
            TextField("메시지 입력", text: $viewModel.inputMessage, axis: .vertical)
                .lineLimit(3)
                .padding(10)
                .background(.baobabGray)
                .cornerRadius(20)
            
            Button {
                
            } label: {
                ZStack {
                    Circle()
                        .frame(width: 30, height: 30)
                    
                    Image(systemName: "arrow.up")
                        .resizable()
                        .frame(width: 12, height: 15)
                        .foregroundStyle(.white)
                }
            }
            .disabled(viewModel.inputMessage.isEmpty)
        }
    }
}

#Preview {
    ChatRoomView(viewModel: AppDI.shared.makeChatRoomViewModel())
}
