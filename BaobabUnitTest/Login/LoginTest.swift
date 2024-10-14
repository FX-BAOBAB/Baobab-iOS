//
//  LoginTest.swift
//  BaobabUnitTest
//
//  Created by 이정훈 on 8/2/24.
//

import XCTest
import Combine
import Alamofire
import Foundation
@testable import Baobab

final class LoginTest: XCTestCase {
    private var dataSource: RemoteDataSource!
    private var tokenRepository: TokenRepositroy!
    private var loginRepository: LoginRepository!
    private var saveTokenUseCase: SaveTokenUseCase!
    private var deleteTokenUseCase: DeleteTokenUseCase!
    private var loginUseCase: LoginUseCase!
    private var cancellables: Set<AnyCancellable>!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        dataSource = RemoteDataSourceImpl()
        loginRepository = LoginRepositoryImpl(dataSource: dataSource)
        tokenRepository = TokenRepositoryImpl()
        saveTokenUseCase = SaveTokenUseCaseImpl(repository: tokenRepository)
        deleteTokenUseCase = DeleteTokenUseCaseImpl(repository: tokenRepository)
        loginUseCase = LoginUseCaseImpl(saveTokenUseCase: saveTokenUseCase,
                                        deleteTokenUseCase: deleteTokenUseCase,
                                        repository: loginRepository)
        cancellables = Set<AnyCancellable>()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        dataSource = nil
        tokenRepository = nil
        loginRepository = nil
        saveTokenUseCase = nil
        deleteTokenUseCase = nil
        loginUseCase = nil
        cancellables = nil
    }
    
    func test_login() {
        //Given
        let params = [
            "result": [
                "resultCode": 0,
                "resultMessage": "string",
                "resultDescription": "string"
            ],
            "body": [
                "email": Bundle.main.email,
                "password": Bundle.main.pw
            ]
        ]
        let expectation = XCTestExpectation(description: "Performs a request")
        
        //When
        loginUseCase.execute(params: params)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Login has been completed")
                case .failure(let error):
                    print("LoginTest.test_login() error : ", error)
                }
            }, receiveValue: {
                //Then
                XCTAssertTrue($0)
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
