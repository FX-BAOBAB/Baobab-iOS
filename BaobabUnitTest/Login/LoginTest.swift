//
//  LoginTest.swift
//  BaobabUnitTest
//
//  Created by 이정훈 on 7/10/24.
//

import XCTest
import Combine
import Alamofire
@testable import Baobab

final class LoginTest: XCTestCase {
    var usecase: LoginUseCase!
    var fetchTokenUseCase: FetchTokenUseCase!
    var repository: LoginRepository!
    var tokenRepository: TokenRepositroy!
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
    
    func test_loginRequest_responseCode_200() {
        //Given
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [LoginSucessMockURLProtocol.self]
        
        let session = Session(configuration: configuration)
        dataSource = RemoteDataSourceImpl(session: session)
        
        let apiEndPoint = Bundle.main.apiUrl + "/open-api/users/login"
        let params = [
            "result": [
                "resultCode": 0,
                "resultMessage": "string",
                "resultDescription": "string"
            ],
            "body": [
                "email": "test@baobab.com",
                "password": "Password1!"
            ]
        ] as [String: Any]
        let expectation = XCTestExpectation(description: "Performs a request")
        
        //When
        dataSource.sendPostRequest(to: apiEndPoint, with: params, resultType: LoginResponseDTO.self)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Login request has been completed")
                case .failure(let error):
                    print("test_loginRequest_responseCode_200() - error : ", error)
                }
            }, receiveValue: {
                //Then
                XCTAssertEqual($0.result.resultCode, 200)
                XCTAssertEqual($0.result.resultDescription, "성공")
                XCTAssertEqual($0.result.resultMessage, "성공")
                
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5)
    }
    
    func test_loginRequest_responseCode_1155() {
        //Given
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [LoginFailMockURLProtocol.self]
        
        let session = Session(configuration: configuration)
        dataSource = RemoteDataSourceImpl(session: session)
        
        let apiEndPoint = Bundle.main.apiUrl + "/open-api/users/login"
        let params = [
            "result": [
                "resultCode": 0,
                "resultMessage": "string",
                "resultDescription": "string"
            ],
            "body": [
                "email": "test@baobab.com",
                "password": "Password1!"
            ]
        ] as [String: Any]
        let expectation = XCTestExpectation(description: "Performs a request")
        
        //When
        dataSource.sendPostRequest(to: apiEndPoint, with: params, resultType: LoginResponseDTO.self)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Login request has been completed")
                case .failure(let error):
                    print("test_loginRequest_responseCode_1155() - error : ", error)
                }
            }, receiveValue: {
                //Then
                XCTAssertEqual($0.result.resultCode, 1155)
                XCTAssertEqual($0.result.resultDescription, "실패")
                XCTAssertEqual($0.result.resultMessage, "로그인 정보가 일치하지 않습니다.")
                
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5)
    }
    
    func test_이메일과비밀번호입력후_로그인시도하면_로그인성공여부를반환함() {
        //Given: 이메일과 비밀번호가 주어짐
        dataSource = RemoteDataSourceImpl()
        let params = [
            "result": [
                "resultCode": 0,
                "resultMessage": "string",
                "resultDescription": "string"
            ],
            "body": [
                "email": "test@baobab.com",
                "password": "Password1!"
            ]
        ] as [String: Any]
        let apiEndPoint = Bundle.main.apiUrl + "/open-api/users/login"
        let expectation = XCTestExpectation(description: "Performs a request")
        
        //When: 아메일과 비밀번호로 로그인을 시도함
        dataSource.sendPostRequest(to: apiEndPoint, with: params, resultType: LoginResponseDTO.self)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Login request has been completed")
                case .failure(let error):
                    print("test_login() error : ", error)
                }
            }, receiveValue: {
                XCTAssertEqual($0.result.resultCode, 200)
                
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5)
    }
    
    func test_loginPerformance() throws {
        self.measure {
//            [Time, seconds] average: 0.547, relative standard deviation: 28.304%, values: [1.009168, 0.496348, 0.503562, 0.493036, 0.502203, 0.515965, 0.448479, 0.507250, 0.494987, 0.501893], performanceMetricID:com.apple.XCTPerformanceMetric_WallClockTime, baselineName: "", baselineAverage: , polarity: prefers smaller, maxPercentRegression: 10.000%, maxPercentRelativeStandardDeviation: 10.000%, maxRegression: 0.100, maxStandardDeviation: 0.100
//            Test Case '-[BaobabUnitTest.LoginTest test_loginPerformance]' passed (5.783 seconds).
//            Test Suite 'LoginTest' passed at 2024-07-11 09:58:23.295.
//                 Executed 1 test, with 0 failures (0 unexpected) in 5.783 (5.784) seconds
            self.test_이메일과비밀번호입력후_로그인시도하면_로그인성공여부를반환함()
        }
    }
    
    func test_이메일과비밀번호를입력하면_로그인시도후_키체인에토큰저장후결과를반환함() {
        //Given: 이메일과 비밀번호가 주어짐
        tokenRepository = TokenRepositoryImpl()
        fetchTokenUseCase = FetchTokenUseCaseImpl(repository: tokenRepository)
        repository = LoginRepositoryImpl(dataSource: RemoteDataSourceImpl())
        usecase = LoginUseCaseImpl(fetchTokenUseCase: fetchTokenUseCase, repository: repository)
        dataSource = RemoteDataSourceImpl()
        let params = [
            "result": [
                "resultCode": 0,
                "resultMessage": "string",
                "resultDescription": "string"
            ],
            "body": [
                "email": "test@baobab.com",
                "password": "Password1!"
            ]
        ] as [String: Any]
        let apiEndPoint = Bundle.main.apiUrl + "/open-api/users/login"
        let expectation = XCTestExpectation(description: "Performs a request")
        
        //When: 로그인 요청
        usecase.execute(params: params)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Login request has been completed")
                case .failure(let error):
                    print("test_login() error : ", error)
                }
            }, receiveValue: {
                XCTAssertTrue($0)
                
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5)
    }
}
