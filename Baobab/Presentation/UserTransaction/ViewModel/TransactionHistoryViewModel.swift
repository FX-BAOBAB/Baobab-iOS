//
//  TransactionHistoryViewModel.swift
//  Baobab
//
//  Created by 이정훈 on 9/11/24.
//

import Combine

final class TransactionHistoryViewModel: ObservableObject {
    @Published var history: TransactionHistory?
    
    private let usecase: FetchTransactionHistoryUseCase
    private var cancellable = Set<AnyCancellable>()
    
    init(usecase: FetchTransactionHistoryUseCase) {
        self.usecase = usecase
    }
    
    func fetchHistroy(usedItemId: Int) {
        usecase.execute(usedItemId: usedItemId)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("The request to fetch the transaction history has been completed")
                case .failure(let error):
                    print("TransactionHistoryViewModel.fetchHistory(usedItem:) error :", error)
                }
            }, receiveValue: { [weak self] in
                self?.history = $0
            })
            .store(in: &cancellable)
    }
}
