//
//  SignUpViewModel+PostSearchable.swift
//  Baobab
//
//  Created by 이정훈 on 7/1/24.
//

import Foundation

extension SignUpViewModel {
    func registerAsSelectedAddress() {
        self.selectedAddress.address = self.searchedAddress
        self.selectedAddress.detailAddress = self.detailedAddressInput
        self.selectedAddress.post = self.searchedPostCode
    }
}
