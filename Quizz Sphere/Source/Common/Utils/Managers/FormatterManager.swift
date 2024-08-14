//
//  FormatterManager.swift
//  Quizz Sphere
//
//  Created by Temur Chitashvili on 13.08.24.
//

import Foundation

final class FormatterManager {
    static let shared = FormatterManager()
    
    private init() { }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
           let seconds: Int = totalSeconds % 60
           let minutes: Int = (totalSeconds / 60) % 60
           return String(format: "%02d:%02d", minutes, seconds)
       }
}
