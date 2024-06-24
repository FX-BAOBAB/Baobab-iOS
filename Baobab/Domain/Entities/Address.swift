//
//  Address.swift
//  Baobab
//
//  Created by 이정훈 on 5/27/24.
//

import Foundation

struct Address: Identifiable {
    var id: Int
    var address: String
    var detailAddress: String
    var post: String
    var isBasicAddress: Bool
}

#if DEBUG
extension Address {
    static var sampleAddressList: [Self] {
        [
            Address(id: 0,
                    address: "경기 성남시 분당구 대왕판교로606번길 45",
                    detailAddress: "◦◦◦호",
                    post: "13524",
                    isBasicAddress: true),
            Address(id: 1,
                    address: "경기도 수원시 영통구 도청로 65",
                    detailAddress: "광교자연앤힐스테이트 5412동 ◦◦◦◦호",
                    post: "16509",
                    isBasicAddress: false)
        ]
    }
}
#endif
