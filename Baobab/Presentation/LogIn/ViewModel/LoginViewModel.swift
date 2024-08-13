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
    @Published var isAsyncTaskProgress: Bool = false
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
        
        isAsyncTaskProgress.toggle()
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
                self?.isAsyncTaskProgress.toggle()
                
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
        isAsyncTaskProgress = true
        
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
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self?.isLoginSuccess = true
                    }
                }
                
                //자동 로그인 완료
                self?.isAsyncTaskProgress = false
                //토큰 갱신 여부와 상관 없이 launch screen을 빠져 나옴
                self?.isShowingLaunchScreen = false
            })
            .store(in: &cancellables)
    }
    
    func deleteToken() {
        isAsyncTaskProgress.toggle()
        
        usecase.deleteToken()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Token deletion is complete")
                case .failure(let error):
                    print("LoginViewModel.deleteToken() error : ", error)
                }
            }, receiveValue: { [weak self] _ in
                self?.isAsyncTaskProgress.toggle()
                self?.isShowingLaunchScreen = false    //삭제 성공 여부에 성관 없이 Launch Screen을 빠져 나감
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
