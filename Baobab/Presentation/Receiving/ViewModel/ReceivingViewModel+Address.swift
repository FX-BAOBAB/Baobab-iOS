//
//  ReceivingViewModel+Address.swift
//  Baobab
//
//  Created by 이정훈 on 5/30/24.
//

import Combine

extension ReceivingViewModel {
    /*
         아래 함수에서는 입고 예약 화면에서 표시되는 단일 기본 주소 업데이트
         주소 선택 화면의 주소 정보는 주소 리스트를 호출하는 함수 참고
     */
    func fetchDefaultAddress() {
        usecase.fetchDefaultAddress()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Request to fetch default address successful")
                case .failure(let error):
                    print("ReceivingViewModel.fetchDefaultAddress() - ", error)
                }
            }, receiveValue: { [weak self] defaultAddress in
                self?.selectedAddress = defaultAddress
            })
            .store(in: &cancellables)
    }
}
