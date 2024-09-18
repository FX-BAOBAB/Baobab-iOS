//
//  RemoteDataSource.swift
//  Baobab
//
//  Created by 이정훈 on 5/29/24.
//

import Combine
@preconcurrency import Alamofire
import Foundation

protocol RemoteDataSource {
    func sendGetRequest<DTO: Decodable>(to url: String,
                                        resultType: DTO.Type) -> AnyPublisher<DTO, Error>
    func sendOpenPostRequest<DTO: Decodable>(to url: String,
                                         with params: Parameters,
                                         resultType: DTO.Type) -> AnyPublisher<DTO, Error>
    func sendPostRequest<DTO>(to url: String,
                              with parameters: Parameters?,
                              resultType: DTO.Type) -> AnyPublisher<DTO, any Error> where DTO: Decodable
    func sendPostRequest<DTO>(to url: String,
                              with parameters: Parameters?,
                              token: String,
                              resultType: DTO.Type) -> AnyPublisher<DTO, any Error> where DTO: Decodable
    func sendUploadRequest<DTO>(to url: String,
                                with parameters: Parameters,
                                resultType: DTO.Type) -> AnyPublisher<DTO, any Error> where DTO: Decodable
}

extension RemoteDataSource {
    func sendPostRequest<DTO>(to url: String,
                              with parameters: Parameters? = nil,
                              resultType: DTO.Type) -> AnyPublisher<DTO, any Error> where DTO: Decodable {
        return Empty().eraseToAnyPublisher()
    }
    
    func sendPostRequest<DTO>(to url: String,
                              with parameters: Parameters? = nil,
                              token: String,
                              resultType: DTO.Type) -> AnyPublisher<DTO, any Error> where DTO: Decodable {
        return Empty().eraseToAnyPublisher()
    }
}

final class RemoteDataSourceImpl: Sendable, RemoteDataSource, RequestInterceptor {
    private let session: Session
    
    init(session: Session = Session.default) {
        self.session = session
    }
    
    //MARK: - GET Request
    func sendGetRequest<DTO>(to url: String,
                             resultType: DTO.Type) -> AnyPublisher<DTO, any Error> where DTO: Decodable {
        return session.request(url, interceptor: self)
                        .publishDecodable(type: resultType)
                        .value()
                        .mapError {
                            $0 as Error
                        }
                        .eraseToAnyPublisher()
    }
    
    //MARK: - POST Request
    func sendOpenPostRequest<DTO>(to url: String,
                                  with params: Parameters,
                                  resultType: DTO.Type) -> AnyPublisher<DTO, any Error> where DTO: Decodable {
        return session.request(url,
                               method: .post,
                               parameters: params,
                               encoding: JSONEncoding.default)
                        .publishDecodable(type: resultType)
                        .value()
                        .mapError {
                            $0 as Error
                        }
                        .eraseToAnyPublisher()
    }
    
    //MARK: - Post request with Interceptor
    func sendPostRequest<DTO>(to url: String,
                              with parameters: Parameters? = nil,
                              resultType: DTO.Type) -> AnyPublisher<DTO, any Error> where DTO: Decodable {
        return session.request(url,
                               method: .post,
                               parameters: parameters,
                               encoding: JSONEncoding.default,
                               interceptor: self)
                        .publishDecodable(type: resultType.self)
                        .value()
                        .mapError {
                            $0 as Error
                        }
                        .eraseToAnyPublisher()
    }
    
    //MARK: - Post request with headers
    func sendPostRequest<DTO>(to url: String,
                              with parameters: Parameters? = nil,
                              token: String,
                              resultType: DTO.Type) -> AnyPublisher<DTO, any Error> where DTO: Decodable {
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        
        return session.request(url,
                               method: .post,
                               parameters: parameters,
                               encoding: JSONEncoding.default,
                               headers: headers)
                        .publishDecodable(type: resultType)
                        .value()
                        .mapError {
                            $0 as Error
                        }
                        .eraseToAnyPublisher()
    }
    
    //MARK: - multipart/form-data
    func sendUploadRequest<DTO>(to url: String,
                                with parameters: Parameters,
                                resultType: DTO.Type) -> AnyPublisher<DTO, any Error> where DTO: Decodable {
        let header: HTTPHeaders = [
            "Content-Type" : "multipart/form-data",
        ]
        
        return session.upload(multipartFormData: { multipartFormData in
            for (key, value) in parameters {
                if let data = value as? Data {
                    multipartFormData.append(data, withName: key, fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                } else if let data = value as? [Data] {
                    data.forEach {
                        multipartFormData.append($0, withName: "\(key)[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                } else if let data = value as? [String] {
                    data.forEach {
                        if let data = "\($0)".data(using: .utf8) {
                            multipartFormData.append(data, withName: "\(key)[]")
                        }
                    }
                } else if let data = value as? String,
                          let data = "\(data)".data(using: .utf8) {
                    multipartFormData.append(data, withName: key)
                }
            }
        }, to: url, method: .post, headers: header, interceptor: self)
        .publishDecodable(type: resultType.self)
        .value()
        .mapError {
            $0 as Error
        }
        .eraseToAnyPublisher()
    }
    
    //MARK: - 네트워크 요청 전 token 관련 header 전처리
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping @Sendable (Result<URLRequest, any Error>) -> Void) {
        Task {
            var urlRequest = urlRequest
            
            guard let accessToken = await TokenKeyChain.read(for: "accessToken") else {
                completion(.failure(RequestError.noTokenValue))
                return
            }
            
            urlRequest.headers.add(.authorization(bearerToken: accessToken))
            completion(.success(urlRequest))
        }
    }
    
    //MARK: - access token 만료일 경우, 수행할 작업
    func retry(_ request: Request, for session: Session, dueTo error: any Error, completion: @escaping @Sendable (RetryResult) -> Void) {
        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 else {
            //타입 캐스팅 실패, 401 에러가 아닌 경우
            //에러와 함께 재시도 없이 리턴
            completion(.doNotRetryWithError(error))
            return
        }
        
        Task { @MainActor in    //TODO: @MainActor 제거
            //Refresh 토큰 가져옴
            guard let refreshToken = await TokenKeyChain.read(for: "refreshToken") else {
                completion(.doNotRetryWithError(RequestError.noTokenValue))
                return
            }
            
            let apiEndPoint = Bundle.main.userOpenURL + "/token/reissue"
            
            do {
                //Access Token 재발급
                for try await newAccessToken in self.sendPostRequest(to: apiEndPoint, token: refreshToken, resultType: AccessTokenRefreshResponseDTO.self).values {
                    await TokenKeyChain.update(token: newAccessToken.body.token, for: "accessToken")
                    
                    if request.retryCount < 1 {
                        //요청 재시도
                        completion(.retry)
                    } else {
                        //재시도 횟수를 초과하면 로그인 페이지로 돌아감
                        completion(.doNotRetry)
                        self.notifyTokenExpiration()
                    }
                }
            } catch {
                completion(.doNotRetryWithError(error))
                self.notifyTokenExpiration()
            }
        }
    }
    
    //MARK: - Refresh Token 만료시 NotificationCenter를 통해 알림
    private func notifyTokenExpiration() {
        print("토큰 만료 알림 전송")
        NotificationCenter.default.post(name: .refreshTokenExpiration, object: nil, userInfo: ["isTokenExpired": true])
    }
}
