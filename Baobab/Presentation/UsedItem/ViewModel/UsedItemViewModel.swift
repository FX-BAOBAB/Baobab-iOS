//
//  UsedItemViewModel.swift
//  Baobab
//
//  Created by 이정훈 on 9/7/24.
//

import Combine

final class UsedItemViewModel: ObservableObject {
    @Published var isShowingAlert: Bool = false
    @Published var isLoading: Bool = false
    
    var alertType: AlertType = .none
    private let usecase: BuyUsedItemUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(usecase: BuyUsedItemUseCase) {
        self.usecase = usecase
    }
    
    func buy(itemId: Int) {
        isLoading.toggle()
        
        usecase.execute(for: itemId)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isShowingAlert.toggle()
                self?.isLoading.toggle()
                
                switch completion {
                case .finished:
                    print("The request to buy an item has been completed")
                case .failure(let error):
                    print("UsedItemViewModel.buy(itemId:) error :", error)
                }
            }, receiveValue: { [weak self] in
                if $0 {
                    self?.alertType = .success
                } else {
                    self?.alertType = .failure
                }
            })
            .store(in: &cancellables)
    }
}
