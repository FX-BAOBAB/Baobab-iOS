//
//  MainViewModel.swift
//  Baobab
//
//  Created by 이정훈 on 8/13/24.
//

import Combine
import Foundation

final class MainViewModel: ObservableObject {
    @Published var isTokenDeleted: Bool = false
    
    private let usecase: FetchTokenUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(usecase: FetchTokenUseCase) {
        self.usecase = usecase
    }
    
    func deleteToken() {
        usecase.executeTokenDelete(for: "accessToken")
            .merge(with: usecase.executeTokenDelete(for: "refreshToken"))
            .receive(on: DispatchQueue.main)
            .collect()
            .sink { [weak self] results in
                if results.allSatisfy({ $0 == true }) {
                    UserDefaults.standard.setValue(false, forKey: "hasToken")    //토큰 상태 업데이트
                    self?.isTokenDeleted = true
                }
            }
            .store(in: &cancellables)
    }
}
