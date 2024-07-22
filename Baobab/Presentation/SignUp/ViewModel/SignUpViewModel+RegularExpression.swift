//
//  SignUpViewModel+RegularExpression.swift
//  Baobab
//
//  Created by 이정훈 on 6/28/24.
//

import Foundation

extension SignUpViewModel {
    //MARK: - 이메일 정규 표현식
    func isValidEmail(_ email: String) -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        
        return emailPredicate.evaluate(with: email)
    }
    
    //MARK: - 비밀번호 정규 표현식
    func isValidPassword(_ pw: String) -> Bool {
        //비밀번호는 최소 하나의 대문자, 하나의 소문자, 하나의 숫자, 하나의 특수문자를 포함하여 최소 8자리 이상으로 구성
        let regex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,100}"
        let pwPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        
        return pwPredicate.evaluate(with: pw)
    }
    
    //MARK: - 비밀번호 확인
    func confirmPassword() -> Bool {
        if password == passwordConfirm {
            return true
        }
        
        return false
    }
    
    //MARK: - 닉네임 확인
    func isKoreanOnly(_ nickName: String) -> Bool {
        //닉네임은 최대 50자, 한글로만 구성
        let nickRegex = "^[가-힣]{1,50}"
        let nickNamePredicate = NSPredicate(format: "SELF MATCHES %@", nickRegex)
        
        return nickNamePredicate.evaluate(with: nickName)
    }
}
