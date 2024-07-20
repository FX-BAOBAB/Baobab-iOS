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
        
        cancellables = Set<AnyCancellable>()
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
        let apiEndPoint = Bundle.main.openURL + "/users"
        let params: [String: Any] = [String: Any]()
        let expectation = XCTestExpectation(description: "Performs a request")
        
        //When
        dataSource.sendOpenPostRequest(to: apiEndPoint, with: params, resultType: SignUpResponseDTO.self)
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
                XCTAssertEqual($0.body?.message, "회원 가입이 완료되었습니다.")
                
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5)
    }
    
    func test_signUpRequest_responseCode_1154() {
        //Given
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [SignUpFailMockURLProtocol.self]
        
        let session = Session(configuration: configuration)
        dataSource = RemoteDataSourceImpl(session: session)
        
        let apiEndPoint = Bundle.main.openURL + "/users"
        let params: [String: Any] = [String: Any]()
        let expectation = XCTestExpectation(description: "Performs a request")
        
        //When
        dataSource.sendOpenPostRequest(to: apiEndPoint, with: params, resultType: SignUpResponseDTO.self)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Sign-up request has been completed")
                case .failure(let error):
                    print("test_signUpRequest_responseCode_1154() error : " , error)
                }
            }, receiveValue: {
                //Then
                XCTAssertEqual($0.result.resultCode, 1154)
                XCTAssertEqual($0.result.resultDescription, "실패")
                XCTAssertEqual($0.result.resultMessage, "이미 존재하는 아이디입니다.")
                XCTAssertNil($0.body?.message)
                
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5)
    }
    
    func test_signUp() {
        //Given
        dataSource = RemoteDataSourceImpl()
        
        let apiEndPoint = Bundle.main.openURL + "/users"
        let params: [String: Any] = [
            "result": [
                "resultCode": 0,
                "resultMessage": "string",
                "resultDescription": "string"
            ],
            "body": [
                "email": "test@baobab.com",
                "password": "Password1!",
                "name": "홍길동",
                "address": "string",
                "detailAddress": "string",
                "basicAddress": true,
                "post": 123456
            ]
        ]
        let expectation = XCTestExpectation(description: "Performs a request")
        
        //When
        dataSource.sendOpenPostRequest(to: apiEndPoint, with: params, resultType: SignUpResponseDTO.self)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Sign-up request has been completed")
                case .failure(let error):
                    print("test_signUp() error : " , error)
                }
            }, receiveValue: {
                //Then
                XCTAssertEqual($0.result.resultCode, 200)
                XCTAssertEqual($0.result.resultDescription, "성공")
                XCTAssertEqual($0.result.resultMessage, "성공")
                XCTAssertEqual($0.body?.message, "회원 가입이 완료되었습니다.")
                
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5)
    }
}
