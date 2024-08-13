//
//  LogInViewModel.swift
//  Baobab
//
//  Created by 이정훈 on 7/1/24.
//

import Combine
import Foundation

final class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isKeepLoggedIn: Bool = false
    @Published var isLoginProgress: Bool = false
    @Published var isLoginSuccess: Bool = false
    @Published var isShowingLoginAlert: Bool = false
    @Published var isShowingLaunchScreen: Bool = true
    
    var alertType: AlertType?
    private let usecase: LoginUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(usecase: LoginUseCase) {
        self.usecase = usecase
    }
    
    func login() {
        guard !isEmptyInput() else {
            alertType = .blank
            isShowingLoginAlert.toggle()
            return
        }
        
        let data = [
            "result": [
                "resultCode": 0,
                "resultMessage": "string",
                "resultDescription": "string"
            ],
            "body": [
                "email": email,
                "password": password
            ]
        ] as [String: Any]
        
        isLoginProgress.toggle()
        usecase.execute(params: data)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Login requst has been completed")
                case .failure(let error):
                    print("LoginViewModel.login() error : ", error)
                }
            }, receiveValue: { [weak self] loginResult in
                self?.isLoginProgress.toggle()
                
                if loginResult {
                    self?.isLoginSuccess.toggle()
                } else {
                    self?.alertType = .loginError
                    self?.isShowingLoginAlert.toggle()
                }
            })
            .store(in: &cancellables)
    }
    
    func updateRefreshToken() {
        isLoginProgress.toggle()
        
        usecase.updateRefreshToken()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Refresh Token update completed")
                case .failure(let error):
                    print("LoginViewModel.updateAccessToken() error : ", error)
                }
            }, receiveValue: { [weak self] result in
                if result {
                    self?.isLoginSuccess = true
                }
                
                //토큰 갱신 여부와 상관 없이 launch screen을 빠져 나옴
                self?.isShowingLaunchScreen = false
                //자동 로그인 완료
                self?.isLoginProgress.toggle()
            })
            .store(in: &cancellables)
    }
}

extension LoginViewModel {
    enum AlertType {
        case blank
        case loginError
    }
    
    private func isEmptyInput() -> Bool {
        guard !(email.isEmpty) && !(password.isEmpty) else {
            return true
        }
        
        return false
    }
}
