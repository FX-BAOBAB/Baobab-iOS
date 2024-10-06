//
//  FileUploadTest.swift
//  BaobabUnitTest
//
//  Created by 이정훈 on 10/6/24.
//

import XCTest
import Combine
@testable import Baobab

final class FileUploadTest: XCTestCase {
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

    func testFileUpload() {
        let apiEndPoint = Bundle.main.imageURL + "/image"
        let expectation = XCTestExpectation(description: "Performs a request")
        
        if let filePath = Bundle.main.path(forResource: "mac-studio", ofType: "usdz") {
            do {
                let modelData = try Data(contentsOf: URL(fileURLWithPath: filePath))
                let params = [
                    "file": modelData,
                    "kind": "AR",
                    "captions": "string"
                ] as [String: Any]
                
                dataSource.sendUploadRequest(to: apiEndPoint,
                                             with: params,
                                             resultType: SingleFileUploadResponseDTO.self,
                                             fileExtension: "usdz",
                                             mimeType: "model/usdz+zip")
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        print("The request to upload AR model file has been completed")
                    case .failure(let error):
                        XCTFail("The request to upload AR model file has failed: \(error)")
                        expectation.fulfill()
                    }
                }, receiveValue: {
                    //Then
                    XCTAssertEqual($0.result.resultCode, 200)
                    
                    expectation.fulfill()
                })
                .store(in: &cancellables)
            } catch {
                print(error)
                XCTFail("The request to upload AR model file has failed: \(error)")
            }
        } else {
            XCTFail("The request to upload AR model file has failed")
        }
        
        wait(for: [expectation], timeout: 10)
    }

}
