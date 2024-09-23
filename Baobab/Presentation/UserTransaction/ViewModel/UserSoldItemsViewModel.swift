//
//  UserSoldItemsViewModel.swift
//  Baobab
//
//  Created by 이정훈 on 9/9/24.
//

import Combine

final class UserSoldItemsViewModel: TransactionViewModel {
    @Published var usedItems: [SimpleUsedItem]?
    
    private let usecase: FetchSoldItemsUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(usecase: FetchSoldItemsUseCase) {
        self.usecase = usecase
    }
    
    func fetchHistory() {
        usecase.execute()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("The request to fetch user's sold items has been completed")
                case .failure(let error):
                    print("UserPurchasedItemsViewModel.fetchHistory() error", error)
                }
            }, receiveValue: { [weak self] in
                self?.usedItems = $0
            })
            .store(in: &cancellables)
    }

}
