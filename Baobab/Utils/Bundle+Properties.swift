//
//  Bundle+Properties.swift
//  Baobab
//
//  Created by 이정훈 on 7/9/24.
//

import Foundation

extension Bundle {
    /// Delivery 모듈 Test API 요청을 위한 URL
    var testURL: String {
        guard let file = self.path(forResource: "ServiceInfo", ofType: "plist"),
              let resource = NSDictionary(contentsOfFile: file),
              let url = resource["Test_URL"] as? String else {
            return ""
        }
        
        return url
    }
    
    /// Warehouse 모듈 API 요청을 위한 URL
    var warehouseURL: String {
        guard let file = self.path(forResource: "ServiceInfo", ofType: "plist"),
              let resource = NSDictionary(contentsOfFile: file),
              let url = resource["Warehouse_URL"] as? String else {
            return ""
        }
        
        return url
    }
    
    /// Warehouse 모듈 Open API 요청을 위한 URL
    var warehouseOpenURL: String {
        guard let file = self.path(forResource: "ServiceInfo", ofType: "plist"),
              let resource = NSDictionary(contentsOfFile: file),
              let url = resource["Warehouse_Open_URL"] as? String else {
            return ""
        }
        
        return url
    }
    
    /// User 모듈 Open API 요청을 위한 URL
    var userOpenURL: String {
        guard let file = self.path(forResource: "ServiceInfo", ofType: "plist"),
              let resource = NSDictionary(contentsOfFile: file),
              let url = resource["User_Open_URL"] as? String else {
            return ""
        }
        
        return url
    }
    
    /// User 모듈 API 요청을 위한 URL
    var userURL: String {
        guard let file = self.path(forResource: "ServiceInfo", ofType: "plist"),
              let resource = NSDictionary(contentsOfFile: file),
              let url = resource["User_URL"] as? String else {
            return ""
        }
        
        return url
    }
    
    /// Image 모듈 API 요청을 위한 URL
    var imageURL: String {
        guard let file = self.path(forResource: "ServiceInfo", ofType: "plist"),
              let resource = NSDictionary(contentsOfFile: file),
              let url = resource["Image_URL"] as? String else {
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
