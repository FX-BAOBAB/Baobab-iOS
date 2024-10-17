//
//  AddressCollectionViewModel.swift
//  Baobab
//
//  Created by 이정훈 on 10/16/24.
//

import Combine

final class AddressCollectionViewModel: ObservableObject {
    @Published var defaultAddress: Address?
    @Published var registeredAddresses: [Address] = []
    
    private let usecase: FetchAddressUseCase
    private var cancellables: Set<AnyCancellable> = []
    
    init(usecase: FetchAddressUseCase) {
        self.usecase = usecase
    }
    
    func fetchAddresses() {
        usecase.executeForAddresses()
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
}
