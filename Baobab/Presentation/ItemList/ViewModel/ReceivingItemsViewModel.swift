//
//  ReceivingItemsViewModel.swift
//  Baobab
//
//  Created by 이정훈 on 7/25/24.
//

import Combine

final class ReceivingItemsViewModel: ItemsViewModel {
    @Published var items: [Item]? = nil
    
    private let usecase: FetchItemUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(usecase: FetchItemUseCase) {
        self.usecase = usecase
    }
    
    func fetchItems() {
        usecase.execute(for: .receiving)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Fetching of receiving items data has been completed")
                case .failure(let error):
                    print("ReceivingItemsViewModel.fetchItems() error : " , error)
                }
            }, receiveValue: { [weak self] in
                if let items = $0 {
                    self?.items = items
                } else {
                    self?.items = []
                }
            })
            .store(in: &cancellables)
    }
}
