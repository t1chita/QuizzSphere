//
//  LabelValues.swift
//  Quizz Sphere
//
//  Created by Temur Chitashvili on 28.07.24.
//

import Foundation

public enum LabelValues {
    public enum App {
        static let title: String = "Quizz Sphere"
    }
    
    public enum Scenes {
        public enum SignInSignUp {
            static let logIn: String = "Log In"
            static let signUp: String = "Sign Up"
            static let emailPlaceHolder: String = "t1chitashvili@gmail.com"
            static let passwordPlaceHolder: String = "********"
            static let rememberPassword: String = "Remember Password"
            static let forgotPassword: String = "Forget Password"
            static let nickNamePlaceHolder: String = "tem.ch1t"
            static let emailIsValidString: String = "Email must contains @gmail.com suffix"
            static let nicknameIsValidString: String = "Nickname must not contain #, spaces and it's length should be from 3 to 20 characters."
            static let passwordIsValidString: String = "Password must contains special symbols, one number, one uppercased letter, and it's length should be from 9 characters."
            static let correctInfo: String = "Correct Information"
            static let incorrectFormInfo: String = "User's email or password is incorrect"
        }
        
        public enum Home {
            static let goodMorning: String = "☀️ Good Morning"
            static let goodEvening: String = "🌙 Good Evening"
            static let goodAfternoon: String = "🌇 Good Afternoon"
            static let greeting: String = "Hello"
            static let currentQuizz: String = "Recent Quizz"
        }
    }
}
