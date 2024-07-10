//
//  SignUpTest.swift
//  SignUpTest
//
//  Created by 이정훈 on 7/9/24.
//

import XCTest
import Combine
import Alamofire
@testable import Baobab

final class SignUpTest: XCTestCase {
    var dataSource: RemoteDataSource!
    var cancellables: Set<AnyCancellable>!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        dataSource = nil
        cancellables = nil
    }
    
    func test_signUpRequest_responseCode_200() {
        //Given
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [SignUpSuccessMockURLProtocol.self]
        
        let session = Session(configuration: configuration)
        dataSource = RemoteDataSourceImpl(session: session)
        cancellables = Set<AnyCancellable>()
        let apiEndPoint = Bundle.main.apiUrl + "/open-api/users"
        let params: [String: Any] = ["email": "baobab2@baobab.com",
                                    "password": "Password1!",
                                    "name": "홍길동",
                                    "address": "주소",
                                    "detailAddress": "상세주소",
                                    "basicAddress": true,
                                    "post": 123456]
        let expectation = XCTestExpectation(description: "Performs a request")
        
        //When
        dataSource.sendPostRequest(to: apiEndPoint, with: params, resultType: SignUpResponseDTO.self)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Sign-up request has been completed")
                case .failure(let error):
                    print("test_signUpRequest_responseCode_200() error : " , error)
                }
            }, receiveValue: {
                //Then
                XCTAssertEqual($0.result.resultCode, 200)
                XCTAssertEqual($0.result.resultDescription, "성공")
                XCTAssertEqual($0.result.resultMessage, "성공")
                XCTAssertEqual($0.body.message, "회원 가입이 완료되었습니다.")
                
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5)
    }
}
