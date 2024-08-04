//
//  GreetingManager.swift
//  Quizz Sphere
//
//  Created by Temur Chitashvili on 01.08.24.
//

import Foundation

public struct GreetingLogic {
    static let shared = GreetingLogic()
    
    private init() {}
    
    public func greetingText() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        
        let newDay = 0
        let noon = 12
        let sunset = 18
        let midnight = 24
        
        var greetingText = ""
        
        switch hour {
        case newDay ..< noon:
            greetingText = LabelValues.Scenes.SignInSignUp.goodMorning
        case noon ..< sunset:
            greetingText = LabelValues.Scenes.SignInSignUp.goodAfternoon
        case sunset ..< midnight:
            greetingText = LabelValues.Scenes.SignInSignUp.goodEvening
        default:
            greetingText = LabelValues.Scenes.SignInSignUp.greeting
        }
        
        return greetingText
    }
}
