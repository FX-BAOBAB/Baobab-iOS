//
//  FormRepositoryImpl.swift
//  Baobab
//
//  Created by 이정훈 on 7/29/24.
//

import Combine
import Foundation

final class FormRepositoryImpl: RemoteRepository, FormRepository {
    func fetchReceivingForms() -> AnyPublisher<[FormData], any Error> {
        let apiEndPoint = Bundle.main.requestURL + "/api/receiving"
        
        return dataSource.sendGetRequest(to: apiEndPoint, resultType: FormsResponseDTO.self)
            .map { dto in
                dto.body.receivingResponseList.map {
                    self.getFormData(from: $0)
                }
            }
            .eraseToAnyPublisher()
    }
    
    func fetchReturnForms() -> AnyPublisher<[FormData], any Error> {
        let apiEndPoint = Bundle.main.requestURL + "/api/takeback"
        
        return dataSource.sendGetRequest(to: apiEndPoint, resultType: FormsResponseDTO.self)
            .map { dto in
                dto.body.receivingResponseList.map {
                    self.getFormData(from: $0)
                }
            }
            .eraseToAnyPublisher()
    }
    
    func fetchShippingForms() -> AnyPublisher<[FormData], any Error> {
        let apiEndPoint = Bundle.main.requestURL + "/api/shipping"
        
        return dataSource.sendGetRequest(to: apiEndPoint, resultType: FormsResponseDTO.self)
            .map { dto in
                dto.body.receivingResponseList.map {
                    self.getFormData(from: $0)
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
    
    private func getFormData(from response: ReceivingResponseBody) -> FormData {
        return FormData(id: response.id,
                        visitAddress: response.visitAddress,
                        visitDate: response.visitDate,
                        guaranteeAt: response.guaranteeAt,
                        status: receivingProcess[response.receivingStatus]?.status ?? "",
                        statusDescription: receivingProcess[response.receivingStatus]?.description ?? "", 
                        statusPercentile: nil,
                        items: response.goods.map { goods in self.getItem(from: goods) })
    }
}
