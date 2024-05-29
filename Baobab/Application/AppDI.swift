//
//  AppDI.swift
//  Baobab
//
//  Created by 이정훈 on 5/13/24.
//

import Foundation

final class AppDI {
    static let shared: AppDI = AppDI()
    var storeViewModel: ReceivingViewModel {
        return ReceivingViewModel(itemIdx: 0)
    }
    
    private init() {}
}
