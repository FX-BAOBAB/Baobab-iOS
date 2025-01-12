//
//  UsedItemListViewModel.swift
//  Baobab
//
//  Created by 이정훈 on 9/4/24.
//

import Combine
import Foundation

final class UsedItemListViewModel: ObservableObject {
    @Published var items: [UsedItem]?
    @Published var isLoading: Bool = false
    
    private let usecase: FetchUsedItemUseCase
    
    init(usecase: FetchUsedItemUseCase) {
        self.usecase = usecase
    }
    
    @MainActor
    func fetchUsedItems() async {
        do {
            for try await items in usecase.execute().values {
                print("The request to fetch the used item has been completed")
                self.items = items
            }
        } catch {
            print("UsedTradeViewModel.fetchUsedItem() error :", error)
        }
    }
    
    @MainActor
    func fetchNextUsedItems() async {
        guard let lastItem = items?.last else {
            return
        }
        
        do {
            isLoading.toggle()
            
            for try await items in usecase.execute(after: lastItem.id).values {
                print("The request to fetch the used item has been completed")
                self.isLoading.toggle()
                self.items?.append(contentsOf: items)
            }
        } catch {
            self.isLoading.toggle()
            print("UsedTradeViewModel.fetchNextUsedItem() error :", error)
        }
    }
}
