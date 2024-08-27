//
//  UserInfoViewModel.swift
//  Baobab
//
//  Created by 이정훈 on 7/22/24.
//

import Combine

final class UserInfoViewModel: ObservableObject {
    @Published var defaultAddress: Address?
    @Published var addresses: [Address]?
    @Published var isProgress: Bool = false
    
    private let usecase: FetchAddressUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(usecase: FetchAddressUseCase) {
        self.usecase = usecase
    }
    
    func fetchDefaultAddress() {
        isProgress.toggle()
        
        usecase.executeForDefaultAddress()
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
    
    func fetchAddresses() {
        isProgress.toggle()
        
        usecase.executeForAddresses()
            .sink(receiveCompletion: { [weak self] completion in
                self?.isProgress.toggle()
                
                switch completion {
                case .finished:
                    print("The request to fetch addresses has been completed")
                case .failure(let error):
                    print("UserInfoViewModel.fetchAddresses() error :", error)
                }
            }, receiveValue: { [weak self] in
                self?.addresses = $0
            })
            .store(in: &cancellables)
    }
}
