//
//  SignUpViewModel.swift
//  Baobab
//
//  Created by 이정훈 on 6/27/24.
//

import Combine
import Foundation
import MapKit

final class SignUpViewModel: PostSearchable {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var passwordConfirm: String = ""
    @Published var nickName: String = ""
    @Published var emailState: EmailState = .none
    @Published var passwordState: PasswordState = .none
    @Published var passwordConfirmState: PasswordConfirmState = .none
    @Published var nickNameState: NickNameState = .none
    @Published var selectedAddress: Address?
    @Published var searchedAddress: String = ""
    @Published var searchedAddressRegion: MKCoordinateRegion?
    @Published var searchedPostCode: String = ""
    @Published var detailedAddressInput: String = ""
    @Published var isProgress: Bool = false
    @Published var isShowingAlert: Bool = false
    @Published var isProceccingEmailValidation: Bool = false
    @Published var isProcessingNickNameValidation: Bool = false
    @Published var isAllValid: Bool = false
    
    var cancellables = Set<AnyCancellable>()
    var responseMessage: String = ""
    var signUpResult: Bool = false
    var alertType: AlertType?
    let signUpUseCase: SignUpUseCase
    let fetchGeoCodeUseCase: FetchGeoCodeUseCase
    let checkEmailDuplicationUseCase: CheckEmailDuplicationUseCase
    let checkNickNameDuplicationUseCase: CheckNickNameDuplicationUseCase
    
    init(signUpUseCase: SignUpUseCase,
         fetchGeoCodeUseCase: FetchGeoCodeUseCase,
         checkEmailDuplicationUseCase: CheckEmailDuplicationUseCase,
         checkNickNameDuplicationUseCase: CheckNickNameDuplicationUseCase) {
        self.signUpUseCase = signUpUseCase
        self.fetchGeoCodeUseCase = fetchGeoCodeUseCase
        self.checkEmailDuplicationUseCase = checkEmailDuplicationUseCase
        self.checkNickNameDuplicationUseCase = checkNickNameDuplicationUseCase
        
        bind()
        calculateMapCoordinates()
    }
    
    //MARK: - 회원가입 요청
    func signUp() {        
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
                "address": selectedAddress?.address ?? "",
                "detailAddress": selectedAddress?.detailAddress ?? "",
                "basicAddress": selectedAddress?.isBasicAddress ?? "",
                "post": selectedAddress?.post ?? "",
                "role": "BASIC_USER"
            ]
        ] as [String: Any]
        
        signUpUseCase.execute(data: params)
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
    func confirmAllInputs() {
        if emailState != .isValid {
            isAllValid = false
        } else if passwordState != .isValid {
            isAllValid = false
        } else if passwordConfirmState != .isValid {
            isAllValid = false
        } else if nickNameState != .isValid {
            isAllValid = false
        } else {
            isAllValid = true
        }
    }
}
