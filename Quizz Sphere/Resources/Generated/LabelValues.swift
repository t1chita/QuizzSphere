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
            static let chooseAnAvatar: String = "Choose an avatar"
        }
        
        public enum Home {
            static let goodMorning: String = "☀️ Good Morning"
            static let goodEvening: String = "🌙 Good Evening"
            static let goodAfternoon: String = "🌇 Good Afternoon"
            static let greeting: String = "Hello"
            static let currentQuizz: String = "Recent Quiz"
            static let liveQuizzes: String = "Live Quizzes"
            static let seeAll: String = "See All"
            static let seeLess: String = "See Less"
            static let noName: String = "Unknown Name"
            static let noCategory: String = "Unknown Category"
            static let noQuantity: String = "Unknown Quantity"
        }     
        
        public enum Questions {
            static let areYouReady: String = "Are You Ready?"
            static let ready: String = "Ready"
            static let goBack: String = "Go Back"
            static let noAnswer: String = "Unknown Answer"
            static let successfulPopupTitle: String = "Congratulations 🥳"
            static let successfulPopupMessage: String = "You Earned"
            static let unSuccessfulPopupMessage: String = "You missed it this time. Better luck next time!"
            static let unSuccessfulPopupTitle: String = "Keep Going!✊"
            static let missedPopupTitle: String = "Time's Up! 💣"
            static let missedPopupMessage: String = "You didn't answer in time. Moving to the next question."
            static let points: String = "Points"
            static let next: String = "Next"
            static let complete: String = "Complete"
        }
        
        public enum Result {
            static let quizResult: String = "Quiz Result"
            static let congratulations: String = "Congratulations"
            static let quizIsCompletedTextPartOne: String = "You've completed the quiz with"
            static let quizIsCompletedTextPartTwo: String = "points! Keep challenging yourself and aim even higher next time!"
            static let completedTasks: String = "Completed Tasks"
            static let shareResults: String = "Share Results"
            static let takeNewQuiz: String = "Take New Quiz"
        }
    }
}
