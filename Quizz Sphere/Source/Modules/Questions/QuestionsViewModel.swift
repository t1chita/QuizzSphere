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
    
    let answersCount: Int = 4
    
    var questionIndex: Int = 0
    
    var userIsReadyToPlay: Bool = false
    
    var scoresOnQuiz: Int = 100
    
    var totalScores: Int = 0
    
    var totalTime: Int = 60 {
        didSet { scoresOnQuiz = GameManager.shared.getPoints(timeRemaining: totalTime) }
    }

    //MARK: - Initialisation
    init(quiz: Quiz) {
        self.quiz = quiz
    }
    
    //MARK: - Child Method
    func toggleUserIsReadyToPlay() {
        userIsReadyToPlay.toggle()
    }
    
    func setZeroToScore() {
        scoresOnQuiz = 0
    }
    
    func setPropertiesIfAnswerIsNotLast() {
        totalTime = 60
        questionIndex += 1
    }
    
    //MARK: - Requests
    
    //MARK: - Navigation
}
