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
    let status: ItemStatus?
    let quantity: Int
    let basicImages, defectImages: [ImageData]
}

extension Item: Equatable {
    static func ==(lhs: Item, rhs: Item) -> Bool {
        if lhs.id == rhs.id {
            return true
        }
        
        return false
    }
}

#if DEBUG
extension Item {
    static var sampleData: [Item] {
        return [
            Item(id: 0,
                 name: "iPad",
                 category: "SMALL_FURNITURE", 
                 status: .receiving,
                 quantity: 1,
                 basicImages: [
                    ImageData(imageURL: "https://img.freepik.com/free-vector/laboratory-works-icon-set_1284-16217.jpg?t=st=1725945908~exp=1725949508~hmac=5cc8989a99fb0a2c1742acd9778c4cf2808c5a9d05e0a9402d810beeb13224b4&w=1380",
                              caption: "")
                 ], defectImages: [
                    ImageData(imageURL: "https://cdn.pixabay.com/photo/2022/08/07/20/28/night-7371349_1280.jpg",
                              caption: "테스트"),
                    ImageData(imageURL: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/refurb-ipad-wifi-gold-2020?wid=1144&hei=1144&fmt=jpeg&qlt=90&.v=1626464533000",
                              caption: "테스트")
                 ]),
            
            Item(id: 1,
                 name: "iPad",
                 category: "SMALL_FURNITURE",
                 status: .receiving,
                 quantity: 1,
                 basicImages: [
                    ImageData(imageURL: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/refurb-ipad-wifi-gold-2020?wid=1144&hei=1144&fmt=jpeg&qlt=90&.v=1626464533000",
                              caption: "")
                 ], defectImages: [])
        ]
    }
}
#endif
