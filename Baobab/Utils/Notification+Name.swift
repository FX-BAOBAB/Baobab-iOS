//
//  Notification+Name.swift
//  Baobab
//
//  Created by 이정훈 on 8/13/24.
//

import Foundation

extension Notification.Name {
    static let refreshTokenExpiration = Notification.Name("RefreshTokenExpiration")
    static let usedItemRegistrationComplete = Notification.Name("UsedItemRegistrationComplete")
    static let itemstatusConversionComplete = Notification.Name("ItemStatusConversionComplete")
    static let itemOwnershipAbandonmentComplete = Notification.Name("ItemOwnershipAbandonmentComplete")
}
