//
//  SignUpViewModel+Bind.swift
//  Baobab
//
//  Created by 이정훈 on 7/20/24.
//

import Combine
import Foundation

extension SignUpViewModel {
    //MARK: - TextField 입력감지
    func bind() {
        $email
            .dropFirst()
            .debounce(for: 2, scheduler: DispatchQueue.main)    //마지막 입력으로 입력이 2초 동안 없는 경우 값을 방출
            .sink { [weak self] email in
                if email.isEmpty {
                    self?.emailState = .none
                } else if self?.isValidEmail(email) == true {
                    self?.checkEmailDuplication()
                } else {
                    //유효한 이메일 형식이 아닌 경우
                    self?.emailState = .isInvalid
                }
            }
            .store(in: &cancellables)
        
        $password
            .dropFirst()
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
                
                self?.confirmAllInputs()
            }
            .store(in: &cancellables)
        
        $passwordConfirm
            .dropFirst()
            .debounce(for: 2, scheduler: DispatchQueue.main)
            .sink { [weak self] _ in
                if self?.confirmPassword() == true {
                    self?.passwordConfirmState = .isValid
                } else {
                    //비밀번호가 일치하지 않는 경우
                    self?.passwordConfirmState = .isInvalid
                }
                
                self?.confirmAllInputs()
            }
            .store(in: &cancellables)
        
        $nickName
            .dropFirst()
            .debounce(for: 2, scheduler: DispatchQueue.main)
            .sink { [weak self] nickName in
                if nickName.isEmpty {
                    self?.nickNameState = .none
                } else if self?.isKoreanOnly(nickName) == false {
                    self?.nickNameState = .isInValid
                } else {
                    self?.checkNickNameDuplication()
                }
            }
            .store(in: &cancellables)
    }
    
    private func checkEmailDuplication() {
        let params = [
            "result": [
                "resultCode": 0,
                "resultMessage": "string",
                "resultDescription": "string"
            ],
            "body": [
                "email": email
            ]
        ] as [String: Any]
        
        isProceccingEmailValidation.toggle()
        signUpUseCase.checkEmailDuplication(params: params)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("The email duplication check has been completed")
                case .failure(let error):
                    print("SignUpViewModel.checkEmailDuplication() error : ", error)
                }
            }, receiveValue: { [weak self] in
                if $0 {
                    self?.emailState = .isExist    //email이 이미 존재하는 email인 경우
                } else {
                    self?.emailState = .isValid    //사용 가능한 email인 경우
                }
                
                self?.isProceccingEmailValidation.toggle()
                self?.confirmAllInputs()
            })
            .store(in: &cancellables)
    }
    
    private func checkNickNameDuplication() {
        let params = [
            "result": [
                "resultCode": 0,
                "resultMessage": "string",
                "resultDescription": "string"
            ],
            "body": [
                "name": nickName
            ]
        ] as [String: Any]
        
        isProcessingNickNameValidation.toggle()
        signUpUseCase.checkNickNameDuplication(params: params)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("The nickname duplication check has been completed")
                case .failure(let error):
                    print("SignUpViewModel.checkNickNameDuplication() error : ", error)
                }
            }, receiveValue: { [weak self] in
                if $0 {
                    self?.nickNameState = .isExist    //이미 존재하는 닉네임인 경우
                } else {
                    self?.nickNameState = .isValid    //사용 가능한 닉네임인 경우
                }
                
                self?.isProcessingNickNameValidation.toggle()
                self?.confirmAllInputs()
            })
            .store(in: &cancellables)
    }
}
