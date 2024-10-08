//
//  ReceivingUseCase.swift
//  Baobab
//
//  Created by 이정훈 on 5/29/24.
//

import MapKit
import Combine

//MARK: - ReceivingUseCase protocol
protocol ReceivingUseCase {
    /// 기본주소로 등록되어 있는 주소를 요청하는 함수
    func fetchDefaultAddress() -> AnyPublisher<Address, any Error>
    
    /// 등록된 모든 주소를 요청하는 함수
    func fetchAddresses() -> AnyPublisher<[Address], any Error>
    
    /// 인자로 전달된 주소의 Geo Code를 요청하는 함수
    /// - Parameter address: 주소 문자열
    func fetchGeoCode(of address: String) -> AnyPublisher<MKCoordinateRegion, any Error>
    
    /// - Parameter params: 방문 신청 날짜, 방문지 주소, 결함 인정 시간에 대한 딕셔너리
    /// - Parameter items: 입고 물품 객체 배열
    func execute(params: [String: Any], items: [ItemInput]) -> AnyPublisher<Bool, any Error>
}

//MARK: - ReceivingUseCaseImpl
final class ReceivingUseCaseImpl {
    private let fetchGeoCodeUseCase: FetchGeoCodeUseCase
    private let fetchAddressUseCase: FetchAddressUseCase
    private let uploadFileUseCase: UploadFileUseCase
    private let repository: ReceivingRepository
    
    init(fetchGeoCodeUseCase: FetchGeoCodeUseCase, 
         fetchDefaultAddressUseCase: FetchAddressUseCase,
         uploadFileUseCase: UploadFileUseCase,
         repository: ReceivingRepository) {
        self.fetchGeoCodeUseCase = fetchGeoCodeUseCase
        self.fetchAddressUseCase = fetchDefaultAddressUseCase
        self.uploadFileUseCase = uploadFileUseCase
        self.repository = repository
    }
}

extension ReceivingUseCaseImpl: ReceivingUseCase {    
    func fetchGeoCode(of address: String) -> AnyPublisher<MKCoordinateRegion, any Error> {
        return fetchGeoCodeUseCase.execute(for: address)
    }
    
    func fetchDefaultAddress() -> AnyPublisher<Address, any Error> {
        return fetchAddressUseCase.executeForDefaultAddress()
    }
    
    func fetchAddresses() -> AnyPublisher<[Address], any Error> {
        return fetchAddressUseCase.executeForAddresses()
    }
}

extension ReceivingUseCaseImpl{
    private protocol IdentifiableResponse {
        var index: Int { get }
        var response: [FileUploadResponse] { get }
    }
    
    private struct ImageResponse: IdentifiableResponse {
        let index: Int
        let response: [FileUploadResponse]
    }
    
    private struct ModelResponse: IdentifiableResponse {
        let index: Int
        let response: [FileUploadResponse]
    }
    
    func execute(params: [String : Any], items: [ItemInput]) -> AnyPublisher<Bool, any Error> {
        var publishers = [AnyPublisher<IdentifiableResponse, any Error>]()
        var params = params
        var itemRequests = items.map { item in
            [
                "name": item.itemName,
                "modelName": item.modelName,
                "category": item.engCategory ?? "",
                "quantity": item.itemQuantity,
                "imageIdList": [Int](),
                "arImageId": nil
            ] as [String: Any?]
        }
        
        for (i, item) in items.enumerated() {
            //물품 이미지 업로드
            //어차피 itemImages는 모두 값이 존재해야하기 때문에 dataSource의 [Data]로 타입 캐스팅 가능함.
            publishers.append(uploadImage(index: i, item: item))
            publishers.append(uploadDefectImage(index: i, item: item))
            
            if let fileURL = item.modelFile, let fileData = convertFileToData(fileURL) {
                publishers.append(uploadModelFile(index: i, modelData: fileData))
            }
        }
        
        //여러개의 Publisher 결합
        //MargeMany는 여러개의 Publisher를 하나의 Publisher로 결합
        //각 Publisher의 결과 값을 하나의 배열에 담아서 방출
        return Publishers.MergeMany(publishers)
            .collect()    //publisher들이 방출하는 값을 배열에 모아서 한번에 처리
            .flatMap { identifiableResponses -> AnyPublisher<Bool, any Error> in
                identifiableResponses.forEach {
                    if let _ = $0 as? ImageResponse {
                        if var itemList = itemRequests[$0.index]["imageIdList", default: []] as? [Int] {
                            itemList.append(contentsOf: $0.response.map { response in return response.id })
                            itemRequests[$0.index]["imageIdList"] = itemList
                        }
                    } else if let _ = $0 as? ModelResponse {                        
                        itemRequests[$0.index]["arImageId", default: 0] = $0.response[0].id
                    }
                }
                
                if var body = params["body"] as? [String: Any] {
                    body["goodsRequests"] = itemRequests
                    params["body"] = body
                }
                
                return self.repository.requestReceiving(params: params)
            }
            .eraseToAnyPublisher()
    }
    
    private func uploadImage(index: Int, item: ItemInput) -> AnyPublisher<IdentifiableResponse, any Error> {
        let params = [
            "files": item.itemImages,
            "kind": "BASIC",
            "captions": Array(repeating: "caption", count: item.itemImages.count)
        ] as [String: Any]
        
        return uploadFileUseCase.execute(params: params, fileExtension: "jpeg", mimeType: "image/jpeg")
            .map {
                ImageResponse(index: index, response: $0)
            }
            .eraseToAnyPublisher()
    }
    
    private func uploadDefectImage(index: Int, item: ItemInput) -> AnyPublisher<IdentifiableResponse, any Error> {
        let params = [
            "files": item.defects.map { $0.image },
            "kind": "FAULT",
            "captions": item.defects.map { $0.description }
        ] as [String: Any]
        
        return uploadFileUseCase.execute(params: params, fileExtension: "jpeg", mimeType: "image/jpeg")
            .map {
                ImageResponse(index: index, response: $0)
            }
            .eraseToAnyPublisher()
    }
    
    private func uploadModelFile(index: Int, modelData: Data) -> AnyPublisher<IdentifiableResponse, any Error> {
        let params = [
            "file": modelData,
            "kind": "AR",
            "captions": "string"
        ] as [String: Any]
        
        return uploadFileUseCase.execute(params: params, fileExtension: "usdz", mimeType: "model/usdz+zip")
            .map {
                ModelResponse(index: index, response: [$0])
            }
            .eraseToAnyPublisher()
    }
    
    private func convertFileToData(_ fileURL: URL) -> Data? {
        return try? Data(contentsOf: fileURL)
    }
}
