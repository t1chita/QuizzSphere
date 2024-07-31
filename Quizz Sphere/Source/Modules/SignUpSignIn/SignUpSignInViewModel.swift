//
//  SignUpSignInViewModel.swift
//  Quizz Sphere
//
//  Created by Temur Chitashvili on 25.07.24.
//

import Foundation

final class SignUpSignInViewModel {
    var signInEmail: String = ""
    var signInPassword: String = ""
    
    var signUpPassword: String = ""
    var signUpNickname: String = ""
    var signupEmail: String = ""
    
    var isEmailValid: Bool {
        ValidationManager.shared.isEmailValid(signupEmail)
    }
    
    var isNicknameValid: Bool {
        ValidationManager.shared.isNickNameValid(signUpNickname)
    }
    
    var isPasswordValid: Bool {
        ValidationManager.shared.isPasswordValid(signUpPassword)
    }
    
    func isInputValid(forType type: ValidationType) -> String {
            switch type {
            case .email:
                return LabelValues.Scenes.SignInSignUp.emailIsValidString
            case .nickname:
                return LabelValues.Scenes.SignInSignUp.nicknameIsValidString
            case .password:
                return LabelValues.Scenes.SignInSignUp.passwordIsValidString
        }
    }
    
    func createUser(completion: @escaping (Bool) -> Void) {
        if isEmailValid && isNicknameValid && isPasswordValid {
            print("DEBUG: Validation passed")
            Task {
                try await FirebaseManager.shared.createUser(withEmail: signupEmail, nickName: signUpNickname, password: signUpPassword) { success in
                    switch success {
                    case true:
                        completion(true)
                        print("DEBUG: User Saved On On Firebase")
                    case false:
                        completion(false)
                        print("DEBUG: Can't Save User On Firebase")
                    }
                }
            }
        } else {
            print("DEBUG: Validation failed - Email: \(isEmailValid), Nickname: \(isNicknameValid), Password: \(isPasswordValid)")
        }
    }
}
