//
//  TokenRepositoryImpl.swift
//  Baobab
//
//  Created by 이정훈 on 7/10/24.
//

import Combine

final class TokenRepositoryImpl: TokenRepositroy {
    func create(token: String, for account: String) -> AnyPublisher<Bool, Never> {
        return Future { promise in
            Task(priority: .background) {
                promise(.success(await TokenKeyChain.create(token: token, for: account)))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func read(for account: String) -> AnyPublisher<String?, Never> {
        return Future { promise in
            Task(priority: .background) {
                promise(.success(await TokenKeyChain.read(for: account)))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func update(token: String, for account: String) -> AnyPublisher<Bool, Never> {
        return Future { promise in
            Task(priority: .background) {
                promise(.success(await TokenKeyChain.update(token: token, for: account)))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func delete(for account: String) -> AnyPublisher<Bool, Never> {
        return Future { promise in
            Task(priority: .background) {
                promise(.success(await TokenKeyChain.delete(for: account)))
            }
        }
        .eraseToAnyPublisher()
    }
}
