//
//  ValidationError.swift
//  Quizz Sphere
//
//  Created by Temur Chitashvili on 30.07.24.
//

import Foundation

struct ValidationError: Error {
    let message: String
    
    init(message: String) {
        self.message = message
    }
}
