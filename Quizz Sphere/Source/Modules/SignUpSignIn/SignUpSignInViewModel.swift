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
    var signupAvatarImageUrl: String = ""
    
    var avatars: [Avatar] = [] {
        didSet { onAvatarsChanged?() }
    }
    
    var avatarsCount: Int {
        avatars.count
    }
    
    var isEmailValid: Bool {
        ValidationManager.shared.isEmailValid(signupEmail)
    }
    
    var isNicknameValid: Bool {
        ValidationManager.shared.isNickNameValid(signUpNickname)
    }
    
    var isPasswordValid: Bool {
        ValidationManager.shared.isPasswordValid(signUpPassword)
    }   
    
    var isAvatarImageUrlValid: Bool {
        ValidationManager.shared.isStringEmpty(signupAvatarImageUrl)
    }
    
    var onAvatarsChanged: (() -> Void)?
    
    init() {
        getAvatars()
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
        if isEmailValid && isNicknameValid && isPasswordValid && isAvatarImageUrlValid {
            print("DEBUG: Validation passed")
            Task {
                try await FirebaseManager.shared.createUser(withEmail: signupEmail, 
                                                            nickName: signUpNickname,
                                                            password: signUpPassword,
                                                            avatarImageUrl: signupAvatarImageUrl) { success in
                    switch success {
                    case true:
                        completion(true)
                        print("DEBUG: User Saved On Firebase")
                    case false:
                        completion(false)
                        print("DEBUG: Can't Save User On Firebase")
                    }
                }
            }
        } else {
            print("DEBUG: Validation failed - Email: \(isEmailValid), Nickname: \(isNicknameValid), Password: \(isPasswordValid), AvatarUrl: \(signupAvatarImageUrl)")
        }
    }
    
    func signIn(completion: @escaping (Bool) -> Void) {
        Task {
            try await FirebaseManager.shared.signIn(withEmail: signInEmail,
                                                    password: signInPassword) { success in
                switch success {
                case true:
                    print("DEBUG: User sign in was successfully")
                    completion(true)
                case false :
                    completion(false)
                    print("DEBUG: User can't sign in")
                }
                
            }
        }
    }
    
    private func getAvatars() {
        FirebaseManager.shared.getDocuments(from: "avatars") { [weak self] (avatars: [Avatar]?, error) in
            if error == nil {
                self?.avatars = avatars ?? []
            } else {
                print("DEBUG: Get Avatars Error In ViewModel \(String(describing: error?.localizedDescription))")
            }
        }
    }
}
