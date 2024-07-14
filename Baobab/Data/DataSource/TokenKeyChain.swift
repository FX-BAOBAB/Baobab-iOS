//
//  TokenKeyChain.swift
//  Baobab
//
//  Created by 이정훈 on 7/10/24.
//

import Security
import Foundation

struct TokenKeyChain {
    static let serviceName: String = "Baobab"
    
    @discardableResult
    static func create(token: String, for account: String) async -> Bool {
        let keychainItem = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecAttrService: serviceName,
            kSecValueData: token.data(using: .utf8) as Any
        ] as [String: Any]
        
        let status = SecItemAdd(keychainItem as CFDictionary, nil)
        guard status == errSecSuccess else {
            print("Keychain create Error")
            return false
        }
        
        return true
    }
    
    static func read(for account: String) async -> String? {
        let keychainItem = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecAttrService: serviceName,
            kSecReturnData: true
        ] as [String: Any]
        
        
        var token: AnyObject?
        let status = SecItemCopyMatching(keychainItem as CFDictionary, &token)
        
        guard status == errSecSuccess else {
            print("Token reading Error")
            return nil
        }
        
        return String(data: token as! Data, encoding: .utf8)
    }
    
    @discardableResult
    static func update(token: String, for account: String) async -> Bool {
        let keychainItem = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account
        ] as [String: Any]
        
        let attributes = [
            kSecAttrService: serviceName,
            kSecAttrAccount: account,
            kSecValueData: token.data(using: .utf8) as Any
        ]
        
        let status = SecItemUpdate(keychainItem as CFDictionary, attributes as CFDictionary)
        
        guard status == errSecSuccess else {
            print("Keychain update Error")
            return false
        }
        
        return true
    }
    
    @discardableResult
    static func delete(for account: String) async -> Bool {
        let keychainItem = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: serviceName,
            kSecAttrAccount: account
        ] as [String: Any]
        
        let status = SecItemDelete(keychainItem as CFDictionary)
        
        guard status == errSecSuccess else {
            print("Keychain delete Error")
            return false
        }
        
        return true
    }
}
