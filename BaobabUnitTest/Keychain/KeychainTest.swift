//
//  KeychainTest.swift
//  BaobabUnitTest
//
//  Created by 이정훈 on 7/10/24.
//

import XCTest
import Combine
@testable import Baobab

final class KeychainTest: XCTestCase {
    private var repository: TokenRepositroy!
//    private var usecase: FetchTokenUseCase!
    private var saveTokenUseCase: SaveTokenUseCase!
    private var deleteTokenUseCase: DeleteTokenUseCase!
    private var updateLocalTokenUseCase: UpdateLocalTokenUseCase!
    private var fetchTokenUseCase: FetchTokenUseCase!
    private var cancellables: Set<AnyCancellable>!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        repository = TokenRepositoryImpl()
//        usecase = FetchTokenUseCaseImpl(repository: repository)
        cancellables = Set<AnyCancellable>()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        saveTokenUseCase = nil
        deleteTokenUseCase = nil
        updateLocalTokenUseCase = nil
        fetchTokenUseCase = nil
        repository = nil
    }
    
    func test_로그인에성공했을때_토큰값을키체인에저장하면_성공여부를반환한다() {
        //Given: access token 값이 주워짐
        let sampleAccessToken = "1234567890"
        let account = "accessToken"
        let expectation = XCTestExpectation(description: "Performs a request")
        
        //When: Keychain에 암호화하여 저장
        saveTokenUseCase.execute(token: sampleAccessToken, for: account)
            .sink(receiveValue: {
                //Then: 성공 여부를 반환
                XCTAssertTrue($0)
                
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5)
    }
    
    func test_api요청을위해token값이필요할때_Keychain에서token값을읽은후_토큰값을반환한다() {
        //Given: token 키 값이 주어짐
        let account = "accessToken"
        let expectation = XCTestExpectation(description: "Perfoms a request")
        
        //When: Keychain에서 토큰 값을 읽어옴
        fetchTokenUseCase.execute(for: account)
            .sink(receiveValue: {
                //Then: 토큰 값을 반환함
                XCTAssertEqual($0, "1234567890")
                
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5)
    }
    
    func test_access토큰이만료됐을때_새로운access토큰으로변경후_성공여부를반환한다() {
        //Given: 새로운 토큰 값과 token 키 값이 주어짐
        let newAccessToken = "0987654321"
        let account = "accessToken"
        let expectation = XCTestExpectation(description: "Performs a request")
        
        //when: Keychain에 있는 토큰을 새로운 토큰으로 교체
        updateLocalTokenUseCase.execute(token: newAccessToken, for: account)
            .sink(receiveValue: {
                XCTAssertTrue($0)
                
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5)
    }
    
    func test_토큰삭제요청을했을때_키체인에서삭제후_성공여부를반환한다() {
        //Given: token 키 값이 주어짐
        let account = "accessToken"
        let expactation = XCTestExpectation(description: "Performs a request")
        
        //When: Keychain에서 토큰 값 삭제
        deleteTokenUseCase.execute()
            .sink(receiveValue: { result in
                //Then: 성공 여부를 반환
                XCTAssertTrue(result.allSatisfy{$0 == true})
                
                expactation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expactation], timeout: 5)
    }
}
