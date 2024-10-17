//
//  PostSearchable.swift
//  Baobab
//
//  Created by 이정훈 on 6/28/24.
//

import MapKit

protocol PostSearchable: ObservableObject {
    var searchedAddress: String { get set }
    var defaultAddress: Address? { get set }
    var selectedAddress: Address? { get set }
    var registeredAddresses: [Address] { get set }
    var selectedAddressRegion: MKCoordinateRegion? { get set }
    var searchedAddressRegion: MKCoordinateRegion? { get set }
    var searchedPostCode: String { get set }
    var detailedAddressInput: String { get set }
    
    func fetchAddresses()
    func fetchDefaultAddress()
    func registerAsSelectedAddress()
}

extension PostSearchable {
    //MARK: - 회원가입에서 사용하지 않는 요구사항 구현
    var defaultAddress: Address? {
        get { return nil }
        set {}
    }
    
    var registeredAddresses: [Address] {
        get { return [] }
        set {}
    }
    
    var selectedAddressRegion: MKCoordinateRegion? {
        get { return nil }
        set {}
    }
    
    func fetchAddresses() {}
    func fetchDefaultAddress() {}
    
    //MARK: - 프로토콜을 준수해야하는 모든 클래스에서 구현해야 할 요구사항 구현
    func registerAsSelectedAddress() {
        selectedAddress = Address(id: UUID().hashValue,
                                  address: self.searchedAddress,
                                  detailAddress: self.detailedAddressInput,
                                  post: self.searchedPostCode,
                                  isBasicAddress: false)
    }
    
    func registerAsSelectedAddress(address: Address) {
        selectedAddress = address
    }
}
