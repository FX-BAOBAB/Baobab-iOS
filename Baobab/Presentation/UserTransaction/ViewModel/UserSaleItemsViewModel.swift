//
//  UserSaleItemsViewModel.swift
//  Baobab
//
//  Created by 이정훈 on 9/12/24.
//

import Combine

final class UserSaleItemsViewModel: TransactionViewModel {
    @Published var usedItems: [UsedItem]?
    
    private let usecase: FetchSaleItemsUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(usecase: FetchSaleItemsUseCase) {
        self.usecase = usecase
    }
    
    func fetchHistory() {
        usecase.execute()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("The request to fetch the user's sale items has been completed")
                case .failure(let error):
                    print("UserSaleItemsViewModel.fetchHistory() - error :", error)
                }
            }, receiveValue: { [weak self] in
                self?.usedItems = $0
            })
            .store(in: &cancellables)
    }
}
