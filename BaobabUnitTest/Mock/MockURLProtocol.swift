//
//  MockURLProtocol.swift
//  BaobabUnitTest
//
//  Created by 이정훈 on 7/9/24.
//

import Foundation

protocol MockURLInterface {
    func startLoading()
    func setupMockData() -> Data?
}

class MockURLProtocol: URLProtocol {
    lazy var session: URLSession = {
        let configuration: URLSessionConfiguration = URLSessionConfiguration.ephemeral
        
        return URLSession(configuration: configuration)
    }()
    
    var activeTask: URLSessionTask?
    
    //프로토콜 하위 클래스가 지정된 요청을 처리할 수 있는지 여부
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    //지정된 요청의 정식 버전을 반환
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    //캐시 처리 목적으로 두 요청이 같은지 확인
    //캐시 사용 안함
    override class func requestIsCacheEquivalent(_ a: URLRequest, to b: URLRequest) -> Bool {
        return false
    }
    
    override func stopLoading() {
        activeTask?.cancel()
    }
}
