//
//  UserRepositoryImpl.swift
//  Baobab
//
//  Created by 이정훈 on 5/29/24.
//

import Combine
import Foundation

final class UserRepositoryImpl: RemoteRepository, UserRepository {
    func fetchUserInfo() -> AnyPublisher<UserInfo, any Error> {
        let apiEndPoint = Bundle.main.requestURL + "/users"
        
        return dataSource.sendGetRequest(to: apiEndPoint, resultType: UserInfoResponseDTO.self)
            .map {
                UserInfo(id: $0.body.id,
                         name: $0.body.name,
                         email: $0.body.email,
                         role: $0.body.role)
            }
            .eraseToAnyPublisher()
    }
    
    func fetchAddresses() -> AnyPublisher<[Address], any Error> {
        let apiEndPoint = Bundle.main.requestURL + "/address"
        
        return dataSource.sendGetRequest(to: apiEndPoint, resultType: AddressListResponseDTO.self)
            .map { dto in
                dto.body.addressDtoList.map {
                    Address(id: $0.id,
                            address: $0.address,
                            detailAddress: $0.detailAddress,
                            post: $0.post,
                            isBasicAddress: $0.basicAddress)
                }
            }
            .eraseToAnyPublisher()
    }
    
    func fetchDefaultAddress() -> AnyPublisher<Address, any Error> {
        let apiEndPoint = Bundle.main.requestURL + "/address/basic"

        return dataSource.sendGetRequest(to: apiEndPoint, resultType: DefaultAddressResponseDTO.self)
            .map {
                return Address(id: $0.body.id,
                               address: $0.body.address,
                               detailAddress: $0.body.detailAddress,
                               post: $0.body.post,
                               isBasicAddress: $0.body.basicAddress)
            }
            .eraseToAnyPublisher()
    }
}
