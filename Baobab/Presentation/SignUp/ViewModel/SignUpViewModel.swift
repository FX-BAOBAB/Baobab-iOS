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
    @Published var isShowingReponseAlert: Bool = false
    
    var cancellables = Set<AnyCancellable>()
    var responseMessage: String = ""
    var signUpResult: Bool = false
    let usecase: SignUpUseCase
    
    init(usecase: SignUpUseCase) {
        self.usecase = usecase
        
        bind()
        calculateMapCoordinates()
    }
    
    //MARK: - 회원가입 요청
    func signUp() {
        guard let postCode = Int(searchedPostCode) else {
            isShowingReponseAlert.toggle()
            responseMessage = "우편번호가 정확하지 않아요."
            return
        }
        
        isProgress.toggle()    //회원가입 요청 시작
        let signUpData: [String: Any] = ["email": email,
                          "password": password,
                          "name": nickName,
                          "address": selectedAddress.address,
                          "detailAddress": selectedAddress.detailAddress,
                          "basicAddress": selectedAddress.isBasicAddress,
                          "post": postCode]
        
        usecase.execute(data: signUpData)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Sign-up request has been completed.")
                case .failure(let error):
                    print("SignUpViewModel.signUp() error : " , error)
                }
            }, receiveValue: { [weak self] in
                self?.responseMessage = $0.message
                self?.isShowingReponseAlert.toggle()
                self?.isProgress.toggle()    //회원가입 요청 완료
            })
            .store(in: &cancellables)
    }
    
    //MARK: - 입력감지
    private func bind() {
        $email
            .debounce(for: 2, scheduler: DispatchQueue.main)    //마지막 입력으로 입력이 2초 동안 없는 경우 값을 방출
            .sink { [weak self] email in
                if email.isEmpty {
                    self?.emailState = .none
                } else if self?.isValidEmail(email) == true {
                    self?.emailState = .isValid
                    //TODO: 이메일 중복 여부 확인
                } else {
                    //유효한 이메일 형식이 아닌 경우
                    self?.emailState = .isInvalid
                }
            }
            .store(in: &cancellables)
        
        $password
            .debounce(for: 2, scheduler: DispatchQueue.main)
            .sink { [weak self] pw in
                if pw.isEmpty {
                    self?.passwordState = .none
                } else if self?.isValidPassword(pw) == true {
                    self?.passwordState = .isValid
                } else {
                    //유효한 password 형식이 아닌경우
                    self?.passwordState = .isInvalid
                }
            }
            .store(in: &cancellables)
        
        $passwordConfirm
            .debounce(for: 2, scheduler: DispatchQueue.main)
            .sink { [weak self] _ in
                if self?.confirmPassword() == true {
                    self?.passwordConfirmState = .isValid
                } else {
                    //비밀번호가 일치하지 않는 경우
                    self?.passwordConfirmState = .isInvalid
                }
            }
            .store(in: &cancellables)
        
        $nickName
            .debounce(for: 2, scheduler: DispatchQueue.main)
            .sink { [weak self] nickName in
                if nickName.isEmpty {
                    self?.nickNameState = .none
                } else {
                    //TODO: 닉네임 중복 여부 확인
                }
            }
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
