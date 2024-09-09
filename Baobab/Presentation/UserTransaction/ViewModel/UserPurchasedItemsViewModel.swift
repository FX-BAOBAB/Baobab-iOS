//
//  UserPurchasedItemsViewModel.swift
//  Baobab
//
//  Created by 이정훈 on 9/9/24.
//

import Combine

final class UserPurchasedItemsViewModel: TransactionViewModel {
    @Published var usedItems: [UsedItem]?
    
    private let usecase: FetchPurchasedItemsUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(usecase: FetchPurchasedItemsUseCase) {
        self.usecase = usecase
    }
    
    func fetchHistory() {
        usecase.execute()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("The request to fetch user's purchased items has been completed")
                case .failure(let error):
                    print("UserPurchasedItemsViewModel.fetchHistory() error", error)
                }
            }, receiveValue: { [weak self] in
                self?.usedItems = $0
            })
            .store(in: &cancellables)
    }
}
