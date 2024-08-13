//
//  RemoteDataSource.swift
//  Baobab
//
//  Created by 이정훈 on 5/29/24.
//

import Combine
import Alamofire
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

final class RemoteDataSourceImpl: RemoteDataSource, RequestInterceptor {
    private let session: Session
    private var cancellables = Set<AnyCancellable>()
    
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
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, any Error>) -> Void) {
        Task {
            var urlRequest = urlRequest
            
            guard let accessToken = await TokenKeyChain.read(for: "accessToken") else {
                completion(.failure(RequestError.noValue))
                return
            }
            
            urlRequest.headers.add(.authorization(bearerToken: accessToken))
            completion(.success(urlRequest))
        }
    }
    
    //MARK: - access token 만료일 경우, 수행할 작업
    func retry(_ request: Request, for session: Session, dueTo error: any Error, completion: @escaping (RetryResult) -> Void) {
        guard let response = request.task?.response as? HTTPURLResponse,
              response.statusCode == 401 else {
            //타입 캐스팅 실패, 401 에러가 아닌 경우
            //에러와 함께 재시도 없이 리턴
            completion(.doNotRetryWithError(error))
            return
        }
        
        //Access token 재발급 후 재요청
        refreshAccessToken()
            .sink(receiveCompletion: { [weak self] accessTokencompletion in
                switch accessTokencompletion {
                case .finished:
                    print("Updating the access token has been completed")
                case .failure(let error):
                    completion(.doNotRetryWithError(error))
                    //Access Token 재발급 중 Error 발생하면 로그인 페이지로 돌아감
                    self?.notifyTokenExpiration()
                }
            }, receiveValue: { [weak self] in
                if $0 {
                    if request.retryCount < 1 {
                        completion(.retry)
                    } else {
                        //재시도 횟수를 초과하면 로그인 페이지로 돌아감
                        self?.notifyTokenExpiration()
                    }
                } else {
                    completion(.doNotRetry)
                    //Access Token 재발급 실패하면 로그인 페이지로 돌아감
                    self?.notifyTokenExpiration()
                }
            })
            .store(in: &cancellables)
    }
    
    //MARK: - Access toekn 재발급
    private func refreshAccessToken() -> AnyPublisher<Bool, Error> {
        return Future { promise in
            Task {
                guard let refreshToken = await TokenKeyChain.read(for: "refreshToken") else {
                    promise(.failure(RequestError.noValue))
                    return
                }
                
                let apiEndPoint = Bundle.main.openURL + "/token/reissue"
                self.sendPostRequest(to: apiEndPoint, token: refreshToken, resultType: AccessTokenRefreshResponseDTO.self)
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .finished:
                            print("Requesting new access token has been completed")
                        case .failure(let error):
                            promise(.failure(error))    //리프레시 토큰 만료로 body가 null인 경우 decoding error 전달
                        }
                    }, receiveValue: { newAccessToken in
                        Task {
                            promise(.success(await TokenKeyChain.update(token: newAccessToken.body.token, for: "accessToken")))
                        }
                    })
                    .store(in: &self.cancellables)
            }
        }
        .eraseToAnyPublisher()
    }
    
    //MARK: - Refresh Token 만료시 NotificationCenter를 통해 알림
    private func notifyTokenExpiration() {
        NotificationCenter.default.post(name: .refreshTokenExpiration, object: nil, userInfo: ["isTokenExpired": true])
    }
}
