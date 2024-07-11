//
//  SignUpFailMockURLProtocol.swift
//  BaobabUnitTest
//
//  Created by 이정훈 on 7/10/24.
//

import Foundation

final class SignUpFailMockURLProtocol: MockURLProtocol, MockURLInterface {
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
       let fileName = "SignUp_Fail_Response"
        
        guard let file = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            return Data()
        }
        
        return try? Data(contentsOf: file)
    }
    
    
}
