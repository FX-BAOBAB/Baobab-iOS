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
    func fetchDefaultAddress() -> AnyPublisher<Address, any Error>
    func fetchGeoCode(of address: String) -> AnyPublisher<MKCoordinateRegion, any Error>
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
}

extension ReceivingUseCaseImpl{
    struct IdentifiedReponse {
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
                "category": item.itemCategory ?? "",
                "quantity": item.itemQuantity,
                "imageIdList": [Int]()
            ]
        }
        params["goodsRequests"] = itemRequests
        
        for (i, item) in items.enumerated() {
            //물품 이미지 업로드
            let itemImagePublisher = uploadImageUseCase.execute(params: [
                    "files": item.itemImages.compactMap { $0 },    //Optional에서 값 추출
                    "kind": "BASIC",
                    "caption": Array(repeating: "", count: item.itemImages.count)
                ])
                .map {
                    IdentifiedReponse(index: i, response: $0)
                }
                .eraseToAnyPublisher()
            
            //결함 이미지 업로드
            let defectImagePublisher = uploadImageUseCase.execute(params: [
                    "files": item.defects.map { $0.image },
                    "kind": "FAULT",
                    "caption": item.defects.map { $0.description }
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
            .collect()
            .flatMap { identifiedResponse -> AnyPublisher<Bool, any Error> in
                identifiedResponse.forEach {
                    if let goodsRequests = params["goodsRequests"] as? [[String: Any]] {
                        if var imageIdList = goodsRequests[$0.index]["imageIdList"] as? [Int] {
                            imageIdList.append(contentsOf: $0.response.map { response in
                                return response.id
                            })
                        }
                    }
                }
            
                return self.repository.requestReceiving(params: params)
            }
            .eraseToAnyPublisher()
    }
}
