//
//  QuestionsViewModel.swift
//  Quizz Sphere
//
//  Created by Temur Chitashvili on 12.08.24.
//

import Foundation

final class QuestionsViewModel {
    //MARK: - Properties
    let quiz: Quiz
    
    var userIsReadyToPlay: Bool = false
    
    //MARK: - Initialisation
    init(quiz: Quiz) {
        self.quiz = quiz
    }
    
    //MARK: - Child Method
    func toggleUserIsReadyToPlay() {
        userIsReadyToPlay.toggle()
    }
    
    //MARK: - Requests
    
    //MARK: - Navigation
}
