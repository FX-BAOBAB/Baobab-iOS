//
//  FetchReceivingFormsTest.swift
//  BaobabUnitTest
//
//  Created by 이정훈 on 8/2/24.
//

import XCTest
import Combine
import Foundation
@testable import Baobab

final class FetchFormsTest: XCTestCase {
    private var dataSource: RemoteDataSource!
    private var cancellables: Set<AnyCancellable>!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        dataSource = RemoteDataSourceImpl()
        cancellables = Set<AnyCancellable>()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        dataSource = nil
        cancellables = nil
    }

    func test_fetchReceivingForms() {
        //Given
        let apiEndPoint = Bundle.main.requestURL + "/receiving"
        let expectation = XCTestExpectation(description: "Performs a request")
        
        //When
        dataSource.sendGetRequest(to: apiEndPoint, resultType: ReceivingFormsResponseDTO.self)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Fetching receiving forms has been completed")
                case .failure(let error):
                    print("FetchRecieingFormsTest.test_fetchReceivingForms() error : ", error)
                }
            }, receiveValue: {
                //Then
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
        }
    }

}
