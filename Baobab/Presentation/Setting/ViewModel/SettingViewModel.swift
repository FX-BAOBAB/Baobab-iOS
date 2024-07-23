//
//  SettingViewModel.swift
//  Baobab
//
//  Created by 이정훈 on 7/23/24.
//

import Combine

final class SettingViewModel: ObservableObject {
    @Published var isLogout: Bool = false
    
    private let usecase: FetchTokenUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(usecase: FetchTokenUseCase) {
        self.usecase = usecase
    }
    
    func logout() {
        usecase.executeTokenDelete(for: "accessToken")
            .merge(with: usecase.executeTokenDelete(for: "refreshToken"))
            .collect()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("AccessToken & RefreshToken have been deleted")
                case .failure(let error):
                    print("SettingViewModel.logout() error : " , error)
                }
            }, receiveValue: { [weak self] in
                if $0.allSatisfy({ $0 == true }) {
                    self?.isLogout.toggle()
                }
            })
            .store(in: &cancellables)
    }
}
