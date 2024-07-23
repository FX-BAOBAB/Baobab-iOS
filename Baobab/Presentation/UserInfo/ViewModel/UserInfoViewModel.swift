//
//  UserInfoViewModel.swift
//  Baobab
//
//  Created by 이정훈 on 7/22/24.
//

import Combine

final class UserInfoViewModel: ObservableObject {
    @Published var userInfo: UserInfo?
    
    private let usecase: FetchUserInfoUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(usecase: FetchUserInfoUseCase) {
        self.usecase = usecase
    }
    
    func fetchUserInfo() {
        usecase.execute()
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
}
