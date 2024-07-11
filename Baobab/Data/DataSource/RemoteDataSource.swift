//
//  RemoteDataSource.swift
//  Baobab
//
//  Created by 이정훈 on 5/29/24.
//

import Combine
import Alamofire

protocol RemoteDataSource {
    func sendGetRequest<DTO: Decodable>(to url: String, 
                                        resultType: DTO.Type) -> AnyPublisher<DTO, Error>
    func sendPostRequest<DTO: Decodable>(to url: String,
                                         with params: Parameters,
                                         resultType: DTO.Type) -> AnyPublisher<DTO, Error>
}

final class RemoteDataSourceImpl: RemoteDataSource {
    private let session: Session
    
    init(session: Session = Session.default) {
        self.session = session
    }
    
    //MARK: - GET Request
    func sendGetRequest<DTO>(to url: String, 
                             resultType: DTO.Type) -> AnyPublisher<DTO, any Error> where DTO: Decodable {
        return session.request(url)
                        .publishDecodable(type: resultType)
                        .value()
                        .mapError {
                            $0 as Error
                        }
                        .eraseToAnyPublisher()
    }
    
    //MARK: - POST Request
    func sendPostRequest<DTO>(to url: String, 
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
}
