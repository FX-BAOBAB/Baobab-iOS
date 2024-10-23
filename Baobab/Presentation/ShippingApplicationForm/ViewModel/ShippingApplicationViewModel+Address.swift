//
//  ShippingApplicationViewModel+Address.swift
//  Baobab
//
//  Created by 이정훈 on 8/18/24.
//

import Combine

extension ShippingApplicationViewModel {
    func fetchDefaultAddress() {
        /*
             아래 함수에서는 입고 예약 화면에서 표시되는 단일 기본 주소 업데이트
             주소 선택 화면의 주소 정보는 주소 리스트를 호출하는 함수 참고
         */
        fetchAddressUseCase.executeForDefaultAddress()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("The fetching of the default addresses has been completed")
                case .failure(let error):
                    print("ShippingApplicationViewModel.fetchDefaultAddress() - ", error)
                }
            }, receiveValue: { [weak self] defaultAddress in
                self?.selectedAddress = defaultAddress
            })
            .store(in: &cancellables)
    }
}
