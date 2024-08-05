//
//  Item.swift
//  Baobab
//
//  Created by 이정훈 on 7/25/24.
//

import Foundation

struct Item: Identifiable {
    let id: Int
    let name, category: String
    let quantity: Int
    let basicImages, defectImages: [ImageData]
}

#if DEBUG
extension Item {
    static var sampleData: [Item] {
        return [
            Item(id: 0,
                 name: "iPad",
                 category: "SMALL_FURNITURE",
                 quantity: 1,
                 basicImages: [
                    ImageData(imageURL: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/refurb-ipad-wifi-gold-2020?wid=1144&hei=1144&fmt=jpeg&qlt=90&.v=1626464533000",
                              caption: "")
                 ], defectImages: []),
            
            Item(id: 1,
                 name: "iPad",
                 category: "SMALL_FURNITURE",
                 quantity: 1,
                 basicImages: [
                    ImageData(imageURL: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/refurb-ipad-wifi-gold-2020?wid=1144&hei=1144&fmt=jpeg&qlt=90&.v=1626464533000",
                              caption: "")
                 ], defectImages: [])
        ]
    }
}
#endif
