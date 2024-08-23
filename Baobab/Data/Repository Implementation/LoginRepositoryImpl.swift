//
//  LoginRepositoryImpl.swift
//  Baobab
//
//  Created by 이정훈 on 7/10/24.
//

import Combine
import Foundation

final class LoginRepositoryImpl: RemoteRepository, LoginRepository {
    func login(params: [String: Any]) -> AnyPublisher<LoginResponse, any Error> {
        let apiEndPoint = Bundle.main.userOpenURL + "/users/login"
        
        return dataSource.sendOpenPostRequest(to: apiEndPoint, with: params, resultType: LoginResponseDTO.self)
            .map {
                if $0.result.resultCode == 200 {
                    return LoginResponse(result: true,
                                  accessToken: $0.body?.accessToken ?? "",
                                  refreshToken: $0.body?.refreshToken ?? "")
                } else {
                    return LoginResponse(result: false,
                                  accessToken: nil,
                                  refreshToken: nil)
                }
            }
            .eraseToAnyPublisher()
    }
}
