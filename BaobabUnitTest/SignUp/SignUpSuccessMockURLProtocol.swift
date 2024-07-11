//
//  SignUpSuccessMockURLProtocol.swift
//  BaobabUnitTest
//
//  Created by 이정훈 on 7/10/24.
//

import Foundation

final class SignUpSuccessMockURLProtocol: MockURLProtocol, MockURLInterface {
    //요청의 프로토콜 별 로드 시작
    override func startLoading() {
        let data = setupMockData()
        
        //테스트 response 내보내기
        client?.urlProtocol(self, didReceive: HTTPURLResponse(), cacheStoragePolicy: .notAllowed)
        
        //테스트 JSON 데이터 내보내기
        client?.urlProtocol(self, didLoad: data!)
        
        //로드 완료
        client?.urlProtocolDidFinishLoading(self)
        activeTask = session.dataTask(with: request.urlRequest!)
        activeTask?.cancel()
    }
    
    func setupMockData() -> Data? {
        let fileName = "SignUp_Success_Response"
        
        guard let file = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            return Data()
        }
        
        return try? Data(contentsOf: file)
    }
}
