//
//  UserInfoViewModel.swift
//  Baobab
//
//  Created by 이정훈 on 7/22/24.
//

import MapKit
import Combine

final class UserInfoViewModel: ObservableObject {
    @Published var defaultAddress: Address?
    @Published var isProgress: Bool = false
    
    private let addAddressUseCase: AddAddressUseCase
    private let fetchAddressUseCase: FetchAddressUseCase
    let fetchGeoCodeUseCase: FetchGeoCodeUseCase
    var cancellables = Set<AnyCancellable>()
    
    init(addAddressUseCase: AddAddressUseCase,
         fetchAddressUseCase: FetchAddressUseCase,
         fetchGeoCodeUseCase: FetchGeoCodeUseCase) {
        self.addAddressUseCase = addAddressUseCase
        self.fetchAddressUseCase = fetchAddressUseCase
        self.fetchGeoCodeUseCase = fetchGeoCodeUseCase
    }
    
    func fetchDefaultAddress() {
        isProgress.toggle()
        
        fetchAddressUseCase.executeForDefaultAddress()
            .sink(receiveCompletion: { [weak self] completion in
                self?.isProgress.toggle()
                
                switch completion {
                case .finished:
                    print("The request to fetch the default address has been completed")
                case .failure(let error):
                    print("UserInfoViewModel.fetchDefaultAddress() error :", error)
                }
            }, receiveValue: { [weak self] in
                self?.defaultAddress = $0
            })
            .store(in: &cancellables)
    }
    
    func addNewAddress(address: Address) {
        let params = [
            "result": [
                "resultCode": 0,
                "resultMessage": "string",
                "resultDescription": "string"
            ],
            "body": [
                "address": address.address,
                "detailAddress": address.detailAddress,
                "post": address.post,
                "basicAddress": false
            ]
        ]
        
        addAddressUseCase.execute(params: params)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("The request to add the new address Data has been completed")
                case .failure(let error):
                    print("UserInfoViewModel.addNewAddress() error :", error)
                }
            }, receiveValue: { _ in })
            .store(in: &cancellables)
    }
}
