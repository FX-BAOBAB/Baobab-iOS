//
//  UsedTradeSearchViewModel.swift
//  Baobab
//
//  Created by 이정훈 on 9/6/24.
//

import Combine
import Foundation

final class UsedItemSearchViewModel: ObservableObject {
    @Published var keyword: String = ""
    @Published var searchResult: [UsedItem]?
    
    private let usecase: FetchSearchedUsedItemsUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(usecase: FetchSearchedUsedItemsUseCase) {
        self.usecase = usecase
    }
    
    func bind() {
        $keyword
            .dropFirst(2)    //첫번째 값은 무시
            .debounce(for: .seconds(2), scheduler: DispatchQueue.main)    //입력 후 2초 동안 입력이 없는 경우에 값을 방출함
            .sink(receiveValue: { [weak self] in
                if !($0.isEmpty) {
                    self?.search($0)
                }
            })
            .store(in: &cancellables)
    }
    
    func search(_ keyword: String) {
        usecase.execute(keyword: keyword)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("The request to search for a used item using a keyword has been completed")
                case .failure(let error):
                    print("UsedTradeSearchViewModel.search(_:) error :", error)
                }
            }, receiveValue: { [weak self] in
                self?.searchResult = $0
            })
            .store(in: &cancellables)
    }
}
