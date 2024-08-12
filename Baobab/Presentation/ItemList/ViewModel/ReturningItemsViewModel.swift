//
//  ReturningItemsViewModel.swift
//  Baobab
//
//  Created by 이정훈 on 7/25/24.
//

import Combine

final class ReturningItemsViewModel: ItemsViewModel {
    @Published var items: [Item]? = nil
    
    private let usecase: FetchItemUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(usecase: FetchItemUseCase) {
        self.usecase = usecase
    }
    
    func fetchItems() {
        usecase.execute(for: .returning)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Fetching of returning items has been completed")
                case .failure(let error):
                    print("ReturningViewModel.fetchItems() error : ", error)
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
