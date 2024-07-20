//
//  SignUpRepositoryImpl.swift
//  Baobab
//
//  Created by 이정훈 on 7/9/24.
//

import Combine
import Foundation

final class SignUpRepositoryImpl: RemoteRepository, SignUpRepository {
    func requestNickNameDuplicationCheck(params: [String : Any]) -> AnyPublisher<Bool, any Error> {
        let apiEndPoint = Bundle.main.openURL + "/users/duplication/name"
        
        return dataSource.sendOpenPostRequest(to: apiEndPoint, with: params, resultType: DuplicationCheckDTO.self)
            .map {
                return $0.body.duplication
            }
            .eraseToAnyPublisher()
    }
    
    func requestEmailDuplicationCheck(params: [String : Any]) -> AnyPublisher<Bool, any Error> {
        let apiEndPoint = Bundle.main.openURL + "/users/duplication/email"
        
        return dataSource.sendOpenPostRequest(to: apiEndPoint, with: params, resultType: DuplicationCheckDTO.self)
            .map {
                return $0.body.duplication
            }
            .eraseToAnyPublisher()
    }
    
    func requestSignUp(params: [String: Any]) -> AnyPublisher<SignUpResponse, any Error> {
        let apiEndPoint = Bundle.main.openURL + "/users"
        
        return dataSource.sendOpenPostRequest(to: apiEndPoint, with: params, resultType: SignUpResponseDTO.self)
            .map {
                if $0.result.resultCode == 200 {
                    SignUpResponse(result: true, message: $0.body?.message ?? "")
                } else {
                    SignUpResponse(result: false, message: $0.body?.message ?? "")
                }
            }
            .eraseToAnyPublisher()
    }
}
