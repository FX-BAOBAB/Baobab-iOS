//
//  ReturnedItemsViewModel.swift
//  Baobab
//
//  Created by 이정훈 on 7/25/24.
//

import Combine

final class ReturnedItemsViewModel: ItemsViewModel {
    @Published var items: [Item]? = nil
    
    private let usecase: FetchItemUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(usecase: FetchItemUseCase) {
        self.usecase = usecase
    }
    
    func fetchItems() {
        usecase.execute(for: .returned)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Fetching of returned items has been completed")
                case .failure(let error):
                    print("ReturnedItemsViewModel.fetchItems() error : ", error)
                }
            }, receiveValue: { [weak self] in
                self?.items = $0
            })
            .store(in: &cancellables)
    }
    
    
}
