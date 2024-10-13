//
//  ShippingUseCase.swift
//  Baobab
//
//  Created by 이정훈 on 8/15/24.
//

import MapKit
import Combine

protocol ShippingUseCase {
    func execute(deliveryDate: Date, deliveryAddress: String, items: [Item]) -> AnyPublisher<Bool, any Error>
}

final class ShippingUseCaseImpl: ShippingUseCase {
    private let repository: ShippingApplicationRepository
    
    init(repository: ShippingApplicationRepository) {
        self.repository = repository
    }
    
    func execute(deliveryDate: Date, deliveryAddress: String, items: [Item]) -> AnyPublisher<Bool, any Error> {
        let params = [
            "result": [
                "resultCode": 0,
                "resultMessage": "string",
                "resultDescription": "string"
            ],
            "body": [
                "deliveryDate": deliveryDate.toISOFormat(),
                "deliveryAddress": deliveryAddress,
                "goodsIdList": getItemIdList(items: items)
            ]
        ] as [String: Any]
        
        return repository.requestShipping(params: params)
    }
    
    private func getItemIdList(items: [Item]) -> [Int] {
        return items.map {
            $0.id
        }
    }
}
