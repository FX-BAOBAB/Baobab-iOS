//
//  AddressUnitTest.swift
//  BaobabUnitTest
//
//  Created by 이정훈 on 7/12/24.
//

import XCTest
import Combine
import Foundation
@testable import Baobab

final class AddressUnitTest: XCTestCase {
    var dataSource: RemoteDataSource!
    var repository: UserRepository!
    var tokenRepository: TokenRepositroy!
    var fetchTokenUseCase: FetchTokenUseCase!
    var usecase: FetchAddressUseCase!
    var cancellables: Set<AnyCancellable>!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        dataSource = RemoteDataSourceImpl()
        repository = UserRepositoryImpl(dataSource: dataSource)
        tokenRepository = TokenRepositoryImpl()
        fetchTokenUseCase = FetchTokenUseCaseImpl(repository: tokenRepository)
        usecase = FetchAddressUseCaseImpl(repository: repository)
        
        cancellables = Set<AnyCancellable>()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        dataSource = nil
        repository = nil
        tokenRepository = nil
        fetchTokenUseCase = nil
        usecase = nil
        cancellables = nil
    }

    func test_fetchDefaultAddress() {
        //Given
        let apiEndPoint = Bundle.main.requestURL + "/address/basic"
        let expectation = XCTestExpectation(description: "Performs a request")
        
        //When
        dataSource.sendGetRequest(to: apiEndPoint, resultType: DefaultAddressResponseDTO.self)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Fetching default address request has been completed")
                case .failure(let error):
                    print("test_fetchDefaultAddress error : " , error)
                }
            }, receiveValue: {
                //Then
                XCTAssertEqual($0.body.address, "경기 용인시 기흥구 동백죽전대로 507")
                XCTAssertEqual($0.body.detailAddress, "ooo동 ooo호")
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5)
    }
    
    func test_fetchAdrresses() {
        //Given
        let apiEndPoint = Bundle.main.requestURL + "/address"
        let expectation = XCTestExpectation(description: "Performs a request")
        
        //when
        dataSource.sendGetRequest(to: apiEndPoint, resultType: AddressListResponseDTO.self)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Fetching addresses has been completed")
                case .failure(let error):
                    print("test_fetchAddresses() error : ", error)
                }
            }, receiveValue: {
                XCTAssertEqual($0.result.resultCode, 200)
                
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            
            test_fetchDefaultAddress()
        }
    }

}
