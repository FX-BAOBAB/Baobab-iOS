//
//  Reservable.swift
//  Baobab
//
//  Created by 이정훈 on 8/16/24.
//

import Foundation

protocol Reservable: AnyObject, ObservableObject {
    var reservationDate: Date { get set }
    var selectedAddress: Address? { get set }
    
    func fetchDefaultAddress()
    func registerAsSelectedAddress(address: Address)
}

extension Reservable {
    func registerAsSelectedAddress(address: Address) {
        selectedAddress = address
    }
}
