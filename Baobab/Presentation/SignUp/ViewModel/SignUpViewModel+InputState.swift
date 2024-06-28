//
//  SignUpViewModel+InputState.swift
//  Baobab
//
//  Created by 이정훈 on 6/28/24.
//

import Foundation

extension SignUpViewModel {
    enum EmailState: String {
        case none
        case isInvalid = "잘못된 이메일 형식이에요"
        case isExist = "이미 존재하는 이메일이에요"
        case isValid
    }
    
    enum PasswordState: String {
        case none
        case isInvalid = "대문자, 소문자, 숫자, 특수문자 포함 8자리 이상"
        case isValid
    }
    
    enum PasswordConfirmState: String {
        case none
        case isInvalid = "비밀번호가 일치하지 않아요"
        case isValid
    }
    
    enum NickNameState: String {
        case none
        case isExist = "이미 존재하는 닉네임이에요"
        case isValid
    }
}
