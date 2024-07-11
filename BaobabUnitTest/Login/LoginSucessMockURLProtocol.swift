//
//  LoginSucessMockURLProtocol.swift
//  Baobab
//
//  Created by 이정훈 on 7/10/24.
//

import Foundation

final class LoginSucessMockURLProtocol: MockURLProtocol, MockURLInterface {
    override func startLoading() {
        let data = setupMockData()
        
        client?.urlProtocol(self, didReceive: HTTPURLResponse(), cacheStoragePolicy: .notAllowed)
        
        client?.urlProtocol(self, didLoad: data!)
        
        client?.urlProtocolDidFinishLoading(self)
        activeTask = session.dataTask(with: request.urlRequest!)
        activeTask?.cancel()
    }
    
    func setupMockData() -> Data? {
        let fileName = "Login_Success_Response"
        
        guard let file = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            return Data()
        }
        
        return try? Data(contentsOf: file)
    }
}
