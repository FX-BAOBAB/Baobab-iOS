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
        let apiEndPoint = Bundle.main.warehouseURL + "/receiving"
        
        return dataSource.sendGetRequest(to: apiEndPoint, resultType: ReceivingFormsResponseDTO.self)
            .map { dto in
                dto.body.receivingResponseList.map {
                    self.getReceivingFormData(from: $0)
                }
            }
            .eraseToAnyPublisher()
    }
    
    func fetchReturnForms() -> AnyPublisher<[ReturnForm], any Error> {
        let apiEndPoint = Bundle.main.warehouseURL + "/takeback"
        
        return dataSource.sendGetRequest(to: apiEndPoint, resultType: ReturnFormsResponseDTO.self)
            .map { dto in
                dto.body.takeBackResponseList.map {
                    self.getReturnForm(from: $0)
                }
            }
            .eraseToAnyPublisher()
    }
    
    func fetchShippingForms() -> AnyPublisher<[ShippingFormData], any Error> {
        let apiEndPoint = Bundle.main.warehouseURL + "/shipping"
        
        return dataSource.sendGetRequest(to: apiEndPoint, resultType: ShippingFormsResponseDTO.self)
            .map { dto in
                dto.body.shippingList.map {
                    self.getShippingForm(from: $0)
                }
            }
            .eraseToAnyPublisher()
    }
    
    private func getFileData(_ metaData: FileMetaData) -> FileData {
        return FileData(imageURL: metaData.imageURL, caption: metaData.caption)
    }
    
    private func getItem(from goods: Goods) -> Item {
        return Item(id: goods.id,
                    name: goods.name,
                    category: goods.category,
                    status: ItemStatus(rawValue: goods.status),
                    quantity: goods.quantity,
                    basicImages: goods.basicImages.map { metaData in self.getFileData(metaData) },
                    defectImages: goods.faultImages.map { metaData in self.getFileData(metaData) },
                    arImages: goods.arImages.map { metaData in self.getFileData(metaData)})
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
    
    private func getShippingForm(from shipping: ShippingData) -> ShippingFormData {
        return ShippingFormData(id: shipping.shippingID,
                            deliveryDate: shipping.deliveryDate,
                            deliveryAddress: shipping.deliveryAddress,
                            status: shippingProcess[shipping.status]?.status ?? "",
                            statusDescription: shippingProcess[shipping.status]?.description ?? "",
                            deliveryManID: shipping.deliveryMan,
                            items: shipping.goods.map { goods in self.getItem(from: goods) })
    }
    
    private func getReturnForm(from response: TakeBackResponse) -> ReturnForm {
        return ReturnForm(id: response.id,
                          status: returnProcess[response.status]?.status ?? "",
                          statusDescription: returnProcess[response.status]?.description ?? "",
                          takeBackRequestAt: response.takeBackRequestAt,
                          items: response.goods.map { goods in self.getItem(from: goods) },
                          userID: response.userID)
    }
}
