//
//  MainViewModel.swift
//  Baobab
//
//  Created by 이정훈 on 8/13/24.
//

import Combine
import Foundation

final class MainViewModel: ObservableObject {
    @Published var userInfo: UserInfo?
    @Published var usedItems: [UsedItem]?
    @Published var isTokenDeleted: Bool = false
    
    private let usecase: SetupInitialViewUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(usecase: SetupInitialViewUseCase) {
        self.usecase = usecase
    }
    
    func deleteToken() {
        usecase.executeTokenDeletion()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("AccessToken & RefreshToken have been deleted")
                case .failure(let error):
                    print("MainViewModel.deleteToken() error : " , error)
                }
            }, receiveValue: { [weak self] result in
                if result {
                    UserDefaults.standard.setValue(false, forKey: "hasToken")    //토큰 상태 업데이트
                    self?.isTokenDeleted = true
                }
            })
            .store(in: &cancellables)
    }
    
    func fetchUserInfo() {
        usecase.executeFetchingUserInfo()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Fetching user information has been completed")
                case .failure(let error):
                    print("UserInfoViewModel.fetchUserInfo() error : " , error)
                }
            }, receiveValue: { [weak self] in
                self?.userInfo = $0
            })
            .store(in: &cancellables)
    }
    
    func fetchUsedItems() {
        usecase.fetchUsedItems()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("The reques to fetch used items has been completed")
                case .failure(let error):
                    print("MainViewModel.fetchUsedItems() error :", error)
                }
            }, receiveValue: { [weak self] in
                self?.usedItems = $0
            })
            .store(in: &cancellables)
    }
}
