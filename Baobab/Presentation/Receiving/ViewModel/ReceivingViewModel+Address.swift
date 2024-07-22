//
//  ReceivingViewModel+Address.swift
//  Baobab
//
//  Created by 이정훈 on 5/30/24.
//

import Combine
import Foundation

extension ReceivingViewModel {
    //MARK: - 등록된 기본 주소를 요청하는 함수
    func fetchDefaultAddress() {
        /*
             아래 함수에서는 입고 예약 화면에서 표시되는 단일 기본 주소 업데이트
             주소 선택 화면의 주소 정보는 주소 리스트를 호출하는 함수 참고
         */
        usecase.fetchDefaultAddress()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("The fetching of the default addresses has been completed")
                case .failure(let error):
                    print("ReceivingViewModel.fetchDefaultAddress() - ", error)
                }
            }, receiveValue: { [weak self] defaultAddress in
                self?.selectedAddress = defaultAddress
            })
            .store(in: &cancellables)
    }
    
    //MARK: - 사용자 계정에 등록된 모든 주소를 가져오는 함수
    func fetchAddresses() {
        usecase.fetchAddresses()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("The fetching of the addresses has been completed")
                case .failure(let error):
                    print("ReceivingViewModel.fetchAddresses() error : ", error)
                }
            }, receiveValue: { [weak self] addresses in
                addresses.forEach { address in
                    if address.isBasicAddress {
                        self?.defaultAddress = address
                    } else {
                        self?.registeredAddresses.append(address)
                    }
                }
            })
            .store(in: &cancellables)
    }
    
    //MARK: - 검색한 주소를 방문지 주소로 등록하는 함수
    func registerAsSelectedAddress() {
        self.selectedAddress?.id = UUID().hashValue    //임시 난수
        self.selectedAddress?.address = self.searchedAddress
        self.selectedAddress?.detailAddress = self.detailedAddressInput
        self.selectedAddress?.post = self.searchedPostCode
        self.selectedAddress?.isBasicAddress = false
    }
}
