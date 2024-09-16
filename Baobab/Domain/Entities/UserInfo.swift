//
//  UserInfo.swift
//  Baobab
//
//  Created by 이정훈 on 7/22/24.
//

import Foundation

struct UserInfo: Identifiable {
    let id: Int
    let name: String
    let email: String
    let role: String
}

#if DEBUG
extension UserInfo {
    static var sampleData: Self {
        UserInfo(id: 0,
                 name: "홍길동",
                 email: "baobab@baobab.com",
                 role: "role")
    }
}
#endif
