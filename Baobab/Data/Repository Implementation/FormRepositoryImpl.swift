//
//  FormRepositoryImpl.swift
//  Baobab
//
//  Created by 이정훈 on 7/29/24.
//

import Combine
import Foundation

final class FormRepositoryImpl: RemoteRepository, FormRepository {
    func fetchReceivingForms() -> AnyPublisher<[ReceivingForm], any Error> {
        let apiEndPoint = Bundle.main.requestURL + "/api/receiving"
        
        return dataSource.sendGetRequest(to: apiEndPoint, resultType: ReceivingFormsResponseDTO.self)
            .map { dto in
                dto.body.receivingResponseList.map {
                    self.getReceivingFormData(from: $0)
                }
            }
            .eraseToAnyPublisher()
    }
    
    func fetchReturnForms() -> AnyPublisher<[ReceivingForm], any Error> {
        let apiEndPoint = Bundle.main.requestURL + "/api/takeback"
        
        return dataSource.sendGetRequest(to: apiEndPoint, resultType: ReceivingFormsResponseDTO.self)
            .map { dto in
                dto.body.receivingResponseList.map {
                    self.getReceivingFormData(from: $0)
                }
            }
            .eraseToAnyPublisher()
    }
    
    func fetchShippingForms() -> AnyPublisher<[ShippingForm], any Error> {
        let apiEndPoint = Bundle.main.requestURL + "/api/shipping"
        
        return dataSource.sendGetRequest(to: apiEndPoint, resultType: ShippingFormsResponseDTO.self)
            .map { dto in
                dto.body.shippingList.map {
                    self.getShippingForm(from: $0)
                }
            }
            .eraseToAnyPublisher()
    }
    
    private func getImageData(_ metaData: ImageMetaData) -> ImageData {
        return ImageData(imageURL: metaData.imageURL, caption: metaData.caption)
    }
    
    private func getItem(from goods: Goods) -> Item {
        return Item(id: goods.id,
                    name: goods.name,
                    category: goods.category,
                    quantity: goods.quantity,
                    basicImages: goods.basicImages.map { metaData in self.getImageData(metaData) },
                    defectImages: goods.faultImages.map { metaData in self.getImageData(metaData) })
    }
    
    private func getReceivingFormData(from response: ReceivingResponseBody) -> ReceivingForm {
        return ReceivingForm(id: response.id,
                        visitAddress: response.visitAddress,
                        visitDate: response.visitDate,
                        guaranteeAt: response.guaranteeAt,
                        status: receivingProcess[response.receivingStatus]?.status ?? "",
                        statusDescription: receivingProcess[response.receivingStatus]?.description ?? "", 
                        statusPercentile: nil,
                        items: response.goods.map { goods in self.getItem(from: goods) })
    }
    
    private func getShippingForm(from response: ShippingData) -> ShippingForm {
        return ShippingForm(id: response.shippingID,
                            deliveryDate: response.deliveryDate,
                            deliveryAddress: response.deliveryAddress,
                            status: shippingProcess[response.status]?.status ?? "", 
                            statusDescription: shippingProcess[response.status]?.description ?? "",
                            deliveryManID: response.deliveryManID,
                            items: response.goods.map { goods in self.getItem(from: goods) })
    }
}
