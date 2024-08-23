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
    
    //MARK: - Receiving Forms Test
    func test_fetchReceivingForms() {
        //Given
        let apiEndPoint = Bundle.main.warehouseURL + "/receiving"
        let expectation = XCTestExpectation(description: "Performs a request")
        
        //When
        dataSource.sendGetRequest(to: apiEndPoint, resultType: ReceivingFormsResponseDTO.self)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Fetching receiving forms has been completed")
                case .failure(let error):
                    print("FetchFormsTest.test_fetchReceivingForms() error : ", error)
                }
            }, receiveValue: {
                //Then
                XCTAssertEqual($0.result.resultCode, 200)
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5)
    }
    
    //MARK: - Shipping Forms Test
    func test_fetchShippingForms() {
        //Given
        let apiEndPoint = Bundle.main.warehouseURL + "/shipping"
        let expectation = XCTestExpectation(description: "Performs a request")
        
        //When
        dataSource.sendGetRequest(to: apiEndPoint, resultType: ShippingFormsResponseDTO.self)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Fetching shipping forms has been completed")
                case .failure(let error):
                    print("FetchFormsTest.test_fetchShippingForms() error : ", error)
                }
            }, receiveValue: {
                //Then
                XCTAssertEqual($0.result.resultCode, 200)
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5)
    }
    
    //MARK: - Return Forms Test
    func test_fetchReturnForms() {
        //Given
        let apiEndPoint = Bundle.main.warehouseURL + "/takeback"
        let expectation = XCTestExpectation(description: "Performs a request")
        
        //when
        dataSource.sendGetRequest(to: apiEndPoint, resultType: ReturnFormsResponseDTO.self)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Fetching return forms has been completed")
                case .failure(let error):
                    print("FetchFormsText.test_fetchReturnForms() error : ", error)
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
        }
    }

}
