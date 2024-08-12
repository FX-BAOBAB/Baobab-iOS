//
//  ShippedItemsViewModel.swift
//  Baobab
//
//  Created by 이정훈 on 7/25/24.
//

import Combine

final class ShippedItemsViewModel: ItemsViewModel {
    @Published var items: [Item]? = nil
    
    private let usecase: FetchItemUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(usecase: FetchItemUseCase) {
        self.usecase = usecase
    }
    
    func fetchItems() {
        usecase.execute(for: .shipped)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Fetching of shipped items has been completed")
                case .failure(let error):
                    print("ShippedItemsViewModel.fetchItems() error : ", error)
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
