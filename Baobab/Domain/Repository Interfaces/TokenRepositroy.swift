//
//  KeychainRepositroy.swift
//  Baobab
//
//  Created by 이정훈 on 7/10/24.
//

import Combine

protocol TokenRepositroy {
    func create(token: String, for account: String) -> AnyPublisher<Bool, Never>
    func read(for account: String) -> AnyPublisher<String?, Never>
    func update(token: String, for account: String) -> AnyPublisher<Bool, Never>
    func delete(for account: String) -> AnyPublisher<Bool, Never>
}
