//
//  UserRepository.swift
//  Baobab
//
//  Created by 이정훈 on 5/29/24.
//

import Combine

protocol UserRepository {
    func fetchDefaultAddress() -> AnyPublisher<Address, Error>
    func fetchAddresses() -> AnyPublisher<[Address], Error>
}
