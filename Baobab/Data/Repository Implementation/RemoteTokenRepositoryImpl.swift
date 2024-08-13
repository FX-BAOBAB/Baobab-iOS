//
//  RemoteTokenRepositoryImpl.swift
//  Baobab
//
//  Created by 이정훈 on 8/12/24.
//

import Combine
import Foundation

final class RemoteTokenRepositoryImpl: RemoteRepository, RemoteTokenRepository {
    func fetchNewAccessToken(refreshToken: String) -> AnyPublisher<String, any Error> {
        let apiEndPoint = Bundle.main.openURL + "/token/reissue"
        
        //타입 캐스팅을 하지 않으면 protocol extension에 기본 정의된 함수가 호출됨
        guard let dataSource = dataSource as? RemoteDataSourceImpl else {
            return Fail(error: FetchError.unmatchedType)
                .eraseToAnyPublisher()
        }
        
        return dataSource.sendPostRequest(to: apiEndPoint, token: refreshToken, resultType: AccessTokenRefreshResponseDTO.self)
            .map {
                return $0.body.token
            }
            .eraseToAnyPublisher()
    }
}
