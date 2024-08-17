//
//  ResultViewModel.swift
//  Quizz Sphere
//
//  Created by Temur Chitashvili on 17.08.24.
//

import Foundation

final class ResultViewModel {
    //MARK: - Properties
    let userPoints: Int
    
    let quizQuantity: Int
    
    let completedQuizQuantity: Int
    
    //MARK: - Initialisation
    init(userPoints: Int, quizQuantity: Int, completedQuizQuantity: Int) {
        self.userPoints = userPoints
        self.quizQuantity = quizQuantity
        self.completedQuizQuantity = completedQuizQuantity
    }
    
    //MARK: - Child Method
    
    //MARK: - Requests
    
    //MARK: - Navigation
}
