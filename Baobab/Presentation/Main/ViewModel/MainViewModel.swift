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
    
    private let deleteTokenUseCase: DeleteTokenUseCase
    private let fetchUserInfoUseCase: FetchUserInfoUseCase
    private let fetchUsedItemUseCase: FetchUsedItemUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(deleteTokenUseCase: DeleteTokenUseCase,
         fetchUserInfoUseCase: FetchUserInfoUseCase,
         fetchUsedItemUseCase: FetchUsedItemUseCase) {
        self.deleteTokenUseCase = deleteTokenUseCase
        self.fetchUserInfoUseCase = fetchUserInfoUseCase
        self.fetchUsedItemUseCase = fetchUsedItemUseCase
    }
    
    func deleteToken() {
        deleteTokenUseCase.execute()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("AccessToken & RefreshToken have been deleted")
                case .failure(let error):
                    print("MainViewModel.deleteToken() error : " , error)
                }
            }, receiveValue: { [weak self] result in
                if result.allSatisfy({ $0 == true }) {
                    UserDefaults.standard.setValue(false, forKey: "hasToken")    //토큰 상태 업데이트
                    self?.isTokenDeleted = true
                }
            })
            .store(in: &cancellables)
    }
    
    func fetchUserInfo() {
        fetchUserInfoUseCase.execute()
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
    
    @MainActor
    func fetchUsedItems() {
        fetchUsedItemUseCase.execute()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("The request to fetch used items has been completed")
                case .failure(let error):
                    print("MainViewModel.fetchUsedItems() error :", error)
                }
            }, receiveValue: { [weak self] usedItems in
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self?.usedItems = usedItems
                }
            })
            .store(in: &cancellables)
    }
}
