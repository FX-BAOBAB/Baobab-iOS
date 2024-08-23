//
//  Bundle+Properties.swift
//  Baobab
//
//  Created by 이정훈 on 7/9/24.
//

import Foundation

extension Bundle {
    var warehouseURL: String {
        guard let file = self.path(forResource: "ServiceInfo", ofType: "plist"),
              let resource = NSDictionary(contentsOfFile: file),
              let url = resource["Warehouse_URL"] as? String else {
            return ""
        }
        
        return url
    }
    
    var userOpenURL: String {
        guard let file = self.path(forResource: "ServiceInfo", ofType: "plist"),
              let resource = NSDictionary(contentsOfFile: file),
              let url = resource["User_Open_URL"] as? String else {
            return ""
        }
        
        return url
    }
    
    var userURL: String {
        guard let file = self.path(forResource: "ServiceInfo", ofType: "plist"),
              let resource = NSDictionary(contentsOfFile: file),
              let url = resource["User_URL"] as? String else {
            return ""
        }
        
        return url
    }
    
    var email: String {
        guard let file = self.path(forResource: "ServiceInfo", ofType: "plist"),
              let resource = NSDictionary(contentsOfFile: file),
              let email = resource["Email"] as? String else {
            return ""
        }
        
        return email
    }
    
    var pw: String {
        guard let file = self.path(forResource: "ServiceInfo", ofType: "plist"),
              let resource = NSDictionary(contentsOfFile: file),
              let pw = resource["Password"] as? String else {
            return ""
        }
        
        return pw
    }
}
