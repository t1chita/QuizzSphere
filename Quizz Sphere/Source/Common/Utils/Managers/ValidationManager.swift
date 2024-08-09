//
//  ValidationManager.swift
//  Quizz Sphere
//
//  Created by Temur Chitashvili on 30.07.24.
//

import Foundation

final class ValidationManager {
    static let shared = ValidationManager()
    
    private init() { }
    
    
    func isEmailValid(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
         let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        print("DEBUG: Email validation for \(email): \(emailPred.evaluate(with: email))")
        return emailPred.evaluate(with: email) && email.hasSuffix("@gmail.com")
    }
    
    func isNickNameValid(_ nickName: String) -> Bool {
        if nickName.isEmpty {
            return false
        }
        
        let minLength = 3
        let maxLength = 20
        if nickName.count < minLength || nickName.count > maxLength {
            return false
        }
        
        let nicknameRegex = "^[A-Za-z0-9_-]+$"
        let nicknamePredicate = NSPredicate(format: "SELF MATCHES %@", nicknameRegex)
        if !nicknamePredicate.evaluate(with: nickName) {
            return false
        }
        
        if nickName.hasPrefix(" ") || nickName.hasSuffix(" ") {
            return false
        }
        print("DEBUG: Nickname validation for \(nickName)")
        return true
    }
    
    func isPasswordValid(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Z])(?=.*[!@#$&*])(?=.*[0-9]).{9,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        print("DEBUG: Password validation for \(password)")
        return passwordPredicate.evaluate(with: password)
    }
    
    func isStringEmpty(_ string: String) -> Bool {
        if string.isEmpty {
            return false
        } else {
            return true
        }
    }
}
