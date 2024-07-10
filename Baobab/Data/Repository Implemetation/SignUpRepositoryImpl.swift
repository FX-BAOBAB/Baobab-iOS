//
//  SignUpRepositoryImpl.swift
//  Baobab
//
//  Created by 이정훈 on 7/9/24.
//

import Combine
import Foundation

final class SignUpRepositoryImpl: RemoteRepository, SignUpRepository {
    func requestSignUp(param: [String: Any]) -> AnyPublisher<SignUpResponse, any Error> {
        let apiEndPoint = Bundle.main.apiUrl + "/open-api/users"
        
        return dataSource.sendPostRequest(to: apiEndPoint, with: param, resultType: SignUpResponseDTO.self)
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
