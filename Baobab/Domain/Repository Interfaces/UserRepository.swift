//
//  UserRepository.swift
//  Baobab
//
//  Created by 이정훈 on 5/29/24.
//

import Combine

protocol UserRepository {
    func fetchDefaultAddress() -> AnyPublisher<Address, any Error>
    func fetchAddresses() -> AnyPublisher<[Address], any Error>
    func fetchUserInfo() -> AnyPublisher<UserInfo, any Error>
    func fetchUserInfo(userId: Int) -> AnyPublisher<UserInfo, any Error>
    func addNewAddress(params: [String: Any]) -> AnyPublisher<Bool, any Error>
}
