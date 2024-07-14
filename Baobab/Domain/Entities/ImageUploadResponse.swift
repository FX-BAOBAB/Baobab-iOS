//
//  ImageUploadResponse.swift
//  Baobab
//
//  Created by 이정훈 on 7/13/24.
//

import Foundation

struct ImageUploadRespnose {
    let id: Int
    let serverName: String
    let originalName: String
    let imageUrl: String
    let caption: String
    let kind: String
    let itemId: Int
    let extensions: String
}
