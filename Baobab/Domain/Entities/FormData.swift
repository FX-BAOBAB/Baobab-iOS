//
//  FormData.swift
//  Baobab
//
//  Created by 이정훈 on 8/1/24.
//

import Foundation

protocol FormData: Identifiable {
    var id: Int { get }
    var statusPercentile: Double? { get set }
}

struct ReceivingForm: FormData {
    let id: Int
    let visitAddress, visitDate, guaranteeAt, status, statusDescription: String
    var statusPercentile: Double?
    let items: [Item]
}

#if DEBUG
extension ReceivingForm {
    static var sampleData: [ReceivingForm] {
        return [
            ReceivingForm(id: 0,
                          visitAddress: "테스트",
                          visitDate: "2024-07-26T04:20:53.643Z",
                          guaranteeAt: "2024-07-26T04:20:53.643",
                          status: "접수 중",
                          statusDescription: "접수 요청되어 픽업일정을 조정하는 중입니다.",
                          statusPercentile: 0.2,
                          items: Item.sampleData),
            
            ReceivingForm(id: 1,
                          visitAddress: "테스트",
                          visitDate: "2024-07-26T04:20:53.643Z",
                          guaranteeAt: "2024-07-26T04:20:53.643",
                          status: "접수 중",
                          statusDescription: "접수요청되어 픽업일정을 조정하는 중입니다.",
                          statusPercentile: 0.2,
                          items: [ Item.sampleData[0]]),
            
            ReceivingForm(id: 2,
                          visitAddress: "테스트",
                          visitDate: "2024-07-26T04:20:53.643Z",
                          guaranteeAt: "2024-07-26T04:20:53.643",
                          status: "접수 중",
                          statusDescription: "접수요청되어 픽업일정을 조정하는 중입니다.",
                          statusPercentile: 0.2,
                          items: Item.sampleData)
        ]
    }
}
#endif


struct ShippingForm: FormData {
    let id: Int
    let deliveryDate, deliveryAddress, status, statusDescription: String
    let deliveryManID: Int?
    var statusPercentile: Double?
    let items: [Item]
}

#if DEBUG
extension ShippingForm {
    static var sampleData: [ShippingForm] {
        return [
            ShippingForm(id: 0,
                         deliveryDate: "2024-07-26T04:20:53.643Z",
                         deliveryAddress: "테스트",
                         status: "출고 대기 중",
                         statusDescription: "물품이 창고에서 출고 대기 중 입니다.",
                         deliveryManID: 0,
                         statusPercentile: 0.2,
                         items: [Item.sampleData[0]])
        ]
    }
}
#endif

struct ReturnForm: FormData {
    let id: Int
    let status, statusDescription, takeBackRequestAt: String
    let items: [Item]
    let userID: Int
    var statusPercentile: Double?
}

#if DEBUG
extension ReturnForm {
    static var sampleData: [Self] = [
        ReturnForm(id: 0,
                   status: "접수 중",
                   statusDescription: "반품 접수가 완료되었습니다.",
                   takeBackRequestAt: "2024-07-26T04:20:53.643Z",
                   items: [Item.sampleData[0]],
                   userID: 0,
                   statusPercentile: 0.3)
    ]
}
#endif
