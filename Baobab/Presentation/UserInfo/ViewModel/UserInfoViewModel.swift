//
//  UserInfoViewModel.swift
//  Baobab
//
//  Created by 이정훈 on 7/22/24.
//

import MapKit
import Combine

final class UserInfoViewModel: PostSearchable {
    @Published var searchedAddress: String = ""
    @Published var selectedAddress: Address?
    @Published var searchedAddressRegion: MKCoordinateRegion?
    @Published var searchedPostCode: String = ""
    @Published var detailedAddressInput: String = ""
    @Published var defaultAddress: Address?
    @Published var registeredAddresses: [Address] = []
    @Published var isProgress: Bool = false
    
    let usecase: AddAddressUseCase
    var cancellables = Set<AnyCancellable>()
    
    init(usecase: AddAddressUseCase) {
        self.usecase = usecase
        
        calculateMapCoordinates()
    }
    
    func fetchDefaultAddress() {
        isProgress.toggle()
        
        usecase.fetchDefaultAddress()
            .sink(receiveCompletion: { [weak self] completion in
                self?.isProgress.toggle()
                
                switch completion {
                case .finished:
                    print("The request to fetch the default address has been completed")
                case .failure(let error):
                    print("UserInfoViewModel.fetchDefaultAddress() error :", error)
                }
            }, receiveValue: { [weak self] in
                self?.selectedAddress = $0
            })
            .store(in: &cancellables)
    }
    
    func fetchAddresses() {
        usecase.fetchAddresses()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("The request to fetch addresses has been completed")
                case .failure(let error):
                    print("UserInfoViewModel.fetchAddresses() error :", error)
                }
            }, receiveValue: { [weak self] addresses in
                self?.registeredAddresses = []
                
                addresses.forEach {
                    if $0.isBasicAddress {
                        self?.defaultAddress = $0
                    } else {
                        self?.registeredAddresses.append($0)
                    }
                }
            })
            .store(in: &cancellables)
    }
    
    func addNewAddress() {
        let params = [
            "result": [
                "resultCode": 0,
                "resultMessage": "string",
                "resultDescription": "string"
            ],
            "body": [
                "address": searchedAddress,
                "detailAddress": detailedAddressInput,
                "post": searchedPostCode,
                "basicAddress": false
            ]
        ]
        
        usecase.execute(params: params)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("The request to add the new address Data has been completed")
                case .failure(let error):
                    print("UserInfoViewModel.addNewAddress() error :", error)
                }
            }, receiveValue: { [weak self] in
                if $0 {
                    self?.fetchAddresses()
                }
            })
            .store(in: &cancellables)
    }
}
