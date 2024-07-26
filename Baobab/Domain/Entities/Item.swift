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
