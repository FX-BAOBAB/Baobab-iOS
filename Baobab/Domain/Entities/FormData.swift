//
//  FormData.swift
//  Baobab
//
//  Created by 이정훈 on 7/26/24.
//

import Foundation

struct FormData: Identifiable {
    let id: Int
    let visitAddress, visitDate, guaranteeAt, status, statusDescription: String
    let items: [Item]
}

#if DEBUG
extension FormData {
    static var sampleData: [FormData] {
        return [
            FormData(id: 0,
                     visitAddress: "테스트",
                     visitDate: "2024-07-26T04:20:53.643Z",
                     guaranteeAt: "2024-07-26T04:20:53.643",
                     status: "접수 중",
                     statusDescription: "접수요청되어 픽업일정을 조정하는 중입니다.",
                     items: [
                        Item(id: 1,
                             name: "iPad",
                             category: "SMALL_FURNITURE",
                             quantity: 1,
                             basicImages: [
                                ImageData(imageURL: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/ipad-card-40-pro-202405?wid=680&hei=528&fmt=p-jpg&qlt=95&.v=1713920820026",
                                          caption: "")
                             ], defectImages: []),
                        Item(id: 1,
                             name: "iPad",
                             category: "SMALL_FURNITURE",
                             quantity: 1,
                             basicImages: [
                                ImageData(imageURL: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/ipad-card-40-pro-202405?wid=680&hei=528&fmt=p-jpg&qlt=95&.v=1713920820026",
                                          caption: "")
                             ], defectImages: [])
                     ]),
            FormData(id: 1,
                     visitAddress: "테스트",
                     visitDate: "2024-07-26T04:20:53.643Z",
                     guaranteeAt: "2024-07-26T04:20:53.643",
                     status: "접수 중",
                     statusDescription: "접수요청되어 픽업일정을 조정하는 중입니다.",
                     items: [
                        Item(id: 1,
                             name: "iPad",
                             category: "SMALL_FURNITURE",
                             quantity: 1,
                             basicImages: [
                                ImageData(imageURL: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/refurb-ipad-wifi-gold-2020?wid=1144&hei=1144&fmt=jpeg&qlt=90&.v=1626464533000",
                                          caption: "")
                             ], defectImages: [])
                     ])
        ]
    }
}
#endif
