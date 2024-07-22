//
//  SignUpViewModel.swift
//  Baobab
//
//  Created by 이정훈 on 6/27/24.
//

import Combine
import MapKit
import Foundation

final class SignUpViewModel: PostSearchable {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var passwordConfirm: String = ""
    @Published var nickName: String = ""
    @Published var emailState: EmailState = .none
    @Published var passwordState: PasswordState = .none
    @Published var passwordConfirmState: PasswordConfirmState = .none
    @Published var nickNameState: NickNameState = .none
    @Published var selectedAddress: Address = Address(id: UUID().hashValue, address: "", detailAddress: "", post: "", isBasicAddress: false)
    @Published var searchedAddress: String = ""
    @Published var searchedAddressRegion: MKCoordinateRegion?
    @Published var searchedPostCode: String = ""
    @Published var detailedAddressInput: String = ""
    @Published var isProgress: Bool = false
    @Published var isShowingAlert: Bool = false
    
    var cancellables = Set<AnyCancellable>()
    var responseMessage: String = ""
    var signUpResult: Bool = false
    var alertType: AlertType?
    let usecase: SignUpUseCase
    
    init(usecase: SignUpUseCase) {
        self.usecase = usecase
        
        bind()
        calculateMapCoordinates()
    }
    
    //MARK: - 회원가입 요청
    func signUp() {
        guard let postCode = Int(searchedPostCode) else {
            isShowingAlert.toggle()
            responseMessage = "우편번호가 정확하지 않아요."
            return
        }
        
        isProgress.toggle()    //회원가입 요청 시작
        
        let params = [
            "result": [
                "resultCode": 0,
                "resultMessage": "string",
                "resultDescription": "string"
            ],
            "body": [
                "email": email,
                "password": password,
                "name": nickName,
                "address": selectedAddress.address,
                "detailAddress": selectedAddress.detailAddress,
                "basicAddress": selectedAddress.isBasicAddress,
                "post": postCode
            ]
        ] as [String: Any]
        
        usecase.execute(data: params)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Sign-up request has been completed.")
                case .failure(let error):
                    print("SignUpViewModel.signUp() error : " , error)
                }
            }, receiveValue: { [weak self] in
                self?.responseMessage = $0.message
                
                if $0.result {
                    self?.alertType = .signUpSuccess
                } else {
                    self?.alertType = .signUpError
                }
                
                self?.isShowingAlert.toggle()
                self?.isProgress.toggle()    //회원가입 요청 완료
            })
            .store(in: &cancellables)
    }
    
    //MARK: - 모든 입력 값 유효성 검사
    func confirmAllInputs() -> Bool {
        if emailState != .isValid {
            return false
        }
        
        if passwordState != .isValid {
            return false
        }
        
        if passwordConfirmState != .isValid {
            return false
        }
        
        if nickNameState != .isValid {
            return false
        }
        
        return true
    }
}
