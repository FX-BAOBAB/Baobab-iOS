//
//  WebSocketDataSource.swift
//  Baobab
//
//  Created by 이정훈 on 10/10/24.
//

import Foundation

protocol WebSocketDataSource {
    func connect(to url: URL)
    func disconnect()
}

final class WebSocketDataSourceImpl: WebSocketDataSource {
    private var webSocketTask: URLSessionWebSocketTask?
    
    func connect(to url: URL) {
        webSocketTask = URLSession.shared.webSocketTask(with: url)
        webSocketTask?.resume()
        
    }
    
    func disconnect() {
        webSocketTask?.cancel(with: .goingAway, reason: nil)
    }
}
