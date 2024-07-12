//
//  Bundle+URL.swift
//  Baobab
//
//  Created by 이정훈 on 7/9/24.
//

import Foundation

extension Bundle {
    var apiUrl: String {
        guard let file = self.path(forResource: "ServiceInfo", ofType: "plist"),
              let resource = NSDictionary(contentsOfFile: file),
              let url = resource["API_URL"] as? String else {
            return ""
        }
        
        return url
    }
}
