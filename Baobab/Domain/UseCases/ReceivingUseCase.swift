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
    func execute(params: [String: Any], items: [StoreItem]) -> AnyPublisher<Bool, any Error>
}

//MARK: - ReceivingUseCaseImpl
final class ReceivingUseCaseImpl {
    private let fetchGeoCodeUseCase: FetchGeoCodeUseCase
    private let fetchAddressUseCase: FetchAddressUseCase
    private let uploadImageUseCase: UploadImageUseCase
    private let repository: ReceivingRepository
    
    init(fetchGeoCodeUseCase: FetchGeoCodeUseCase, 
         fetchDefaultAddressUseCase: FetchAddressUseCase,
         uploadImageUseCase: UploadImageUseCase,
         repository: ReceivingRepository) {
        self.fetchGeoCodeUseCase = fetchGeoCodeUseCase
        self.fetchAddressUseCase = fetchDefaultAddressUseCase
        self.uploadImageUseCase = uploadImageUseCase
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
    private struct IdentifiedReponse {
        let index: Int
        let response: [ImageUploadResponse]
    }
    
    func execute(params: [String : Any], items: [StoreItem]) -> AnyPublisher<Bool, any Error> {
        var publishers = [AnyPublisher<IdentifiedReponse, any Error>]()
        var params = params
        let itemRequests = items.map { item in
            [
                "name": item.itemName,
                "modelName": item.itemName,
                "category": "SMALL_FURNITURE",    //TODO: 카테고리 동적으로 변경(영문명)
                "quantity": item.itemQuantity,
                "imageIdList": [Int]()
            ] as [String: Any]
        }

        if var body = params["body"] as? [String: Any] {
            body["goodsRequests"] = itemRequests
            
            params["body"] = body
        }
        
        for (i, item) in items.enumerated() {
            //물품 이미지 업로드
            //어차피 itemImages는 모두 값이 존재해야하기 때문에 dataSource의 [Data]로 타입 캐스팅 가능함.
            let itemImagePublisher = uploadImageUseCase.execute(params: [
                    "files": item.itemImages,
                    "kind": "BASIC",
                    "captions": Array(repeating: "캡션", count: item.itemImages.count)
                ])
                .map {
                    IdentifiedReponse(index: i, response: $0)
                }
                .eraseToAnyPublisher()
            
            //결함 이미지 업로드
            let defectImagePublisher = uploadImageUseCase.execute(params: [
                    "files": item.defects.map { $0.image },
                    "kind": "FAULT",
                    "captions": item.defects.map { $0.description }
                ])
                .map {
                    IdentifiedReponse(index: i, response: $0)
                }
                .eraseToAnyPublisher()
            
            publishers.append(itemImagePublisher)
            publishers.append(defectImagePublisher)
        }
        
        //여러개의 Publisher 결합
        //MargeMany는 여러개의 Publisher를 하나의 Publisher로 결합
        //각 Publisher의 결과 값을 하나의 배열에 담아서 방출
        return Publishers.MergeMany(publishers)
            .collect()    //publisher들이 방출하는 값을 배열에 모아서 한번에 처리
            .flatMap { identifiedResponse -> AnyPublisher<Bool, any Error> in
                identifiedResponse.forEach {
                    if var body = params["body"] as? [String: Any] {
                        if var goodsRequests = body["goodsRequests"] as? [[String: Any]] {
                            if var imageIdList = goodsRequests[$0.index]["imageIdList"] as? [Int] {
                                imageIdList.append(contentsOf: $0.response.map { response in
                                    return response.id
                                })
                                
                                goodsRequests[$0.index]["imageIdList"] = imageIdList
                            }
                            
                            body["goodsRequests"] = goodsRequests
                        }
                        
                        params["body"] = body
                    }
                }
                
                return self.repository.requestReceiving(params: params)
            }
            .eraseToAnyPublisher()
    }
}
