//
//  UsedTradeViewModel.swift
//  Baobab
//
//  Created by 이정훈 on 9/4/24.
//

import Combine
import Foundation

final class UsedTradeViewModel: ObservableObject {
    @Published var items: [UsedItem]?
    
    private let usecase: FetchUsedItemUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(usecase: FetchUsedItemUseCase) {
        self.usecase = usecase
    }
    
    func fetchUsedItems() async {
        do {
            for try await items in usecase.execute().values {
                DispatchQueue.main.async {
                    print("The request to fetch the used item has been completed")
                    self.items = items
                }
            }
        } catch {
            print("UsedTradeViewModel.fetchUsedItem() error :", error)
        }
    }
}
