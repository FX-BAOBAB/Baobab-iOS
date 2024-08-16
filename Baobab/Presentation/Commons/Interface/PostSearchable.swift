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
    var searchedAddressRegion: MKCoordinateRegion? { get set }
    var searchedPostCode: String { get set }
    var detailedAddressInput: String { get set }
    
    func fetchDefaultAddress()
    func registerAsSelectedAddress()
}

extension PostSearchable {
    //MARK: - 검색한 주소를 방문지 주소로 등록하는 함수
    func registerAsSelectedAddress() {
        self.selectedAddress?.id = UUID().hashValue    //임시 난수
        self.selectedAddress?.address = self.searchedAddress
        self.selectedAddress?.detailAddress = self.detailedAddressInput
        self.selectedAddress?.post = self.searchedPostCode
        self.selectedAddress?.isBasicAddress = false
    }
    
    //회원가입에서는 주소 찾기만 필요하기 떄문에 임시 함수 선언
    func fetchDefaultAddress() {}
}
