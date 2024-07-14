//
//  ImageUploadTest.swift
//  BaobabUnitTest
//
//  Created by 이정훈 on 7/13/24.
//

import XCTest
import Combine
@testable import Baobab

final class ImageUploadTest: XCTestCase {
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

    func testSingleImageUpload() {
        //Given
        let apiEndPoint = Bundle.main.apiUrl + "/api/image"
        let imageData = UIImage(named: "SampleImage")?.cropToSquare().downscaleToJpegData(maxBytes: 4_194_304)
        let params = [
              "file": imageData!,
              "kind": "BASIC",
              "caption": "string"
        ] as [String: Any]
        let expectation = XCTestExpectation(description: "Performs a request")
        
        //When
        dataSource.sendUploadRequest(to: apiEndPoint, with: params, resultType: SingleImageUploadResponseDTO.self)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("The image upload has been completed")
                case .failure(let error):
                    print("ImageUpoadTest.test_imageUpload() error : ", error)
                }
            }, receiveValue: {
                //Then
                XCTAssertEqual($0.result.resultCode, 200)
                
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testMultipleImageUpload() {
        //Given
        let apiEndPoint = Bundle.main.apiUrl + "/api/image/list"
        let imageData = UIImage(named: "SampleImage")?.cropToSquare().downscaleToJpegData(maxBytes: 4_194_304)
        let params = [
            "files": Array(repeating: imageData, count: 10),
            "kind": "BASIC",
            "captions": Array(repeating: "캡션", count: 10)
        ] as [String: Any]
        let expectation = XCTestExpectation(description: "Performs a request")
        
        //When
        dataSource.sendUploadRequest(to: apiEndPoint, with: params, resultType: MultipleImageUploadResponseDTO.self)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("The image upload has been completed")
                case .failure(let error):
                    print("ImageUpoadTest.test_imageUpload() error : ", error)
                }
            }, receiveValue: {
                //Then
                XCTAssertEqual($0.result.resultCode, 200)
                
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5)
    }

    func testSingleImageUploadPerformance() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            
            testSingleImageUpload()
        }
    }
}
