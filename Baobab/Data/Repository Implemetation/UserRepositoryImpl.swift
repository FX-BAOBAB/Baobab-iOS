//
//  UserRepositoryImpl.swift
//  Baobab
//
//  Created by 이정훈 on 5/29/24.
//

import Combine

final class UserRepositoryImpl: RemoteRepository, UserRepository {
    func fetchDefaultAddress() -> AnyPublisher<Address, any Error> {
        let url = ""
        return dataSource.sendGetRequest(to: url, resultType: DefaultAddressResponseDTO.self)
            .map { DTO in
                Address(id: DTO.body.address.id,
                        address: DTO.body.address.address,
                        detailAddress: DTO.body.address.detailAddress,
                        post: String(DTO.body.address.post),
                        isBasicAddress: DTO.body.address.basicAddress)
            }
            .eraseToAnyPublisher()
    }
}
