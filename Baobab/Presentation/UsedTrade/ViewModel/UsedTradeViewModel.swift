//
//  UsedTradeViewModel.swift
//  Baobab
//
//  Created by 이정훈 on 9/4/24.
//

import Combine

final class UsedTradeViewModel: ObservableObject {
    @Published var items: [UsedItem]?
    
    private let usecase: FetchUsedItemUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(usecase: FetchUsedItemUseCase) {
        self.usecase = usecase
    }
    
    func fetchUsedItems() {
        usecase.execute()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("The request to fetch the used item has been completed")
                case .failure(let error):
                    print("UsedTradeViewModel.fetchUsedItem() error :", error)
                }
            }, receiveValue: { [weak self] in
                self?.items = $0    // 값이 nil이면 DB에 등록된 중고 물품이 없음
            })
            .store(in: &cancellables)
    }
}
