//
//  HomeViewModel.swift
//  Quizz Sphere
//
//  Created by Temur Chitashvili on 25.07.24.
//

import Foundation

class HomeViewModel {
    var quizzes: [Quiz] = [] {
        didSet { onQuizzesChanged?()}
    }
    
    var quizzesCount: Int {
        quizzes.count
    }
    
    var onQuizzesChanged: (() -> Void)?
    
    init() {
        getQuizzes()
    }
    
    private func getQuizzes() {
        FirebaseManager.shared.getQuizzes { [weak self] quizzes, error in
            if error == nil {
                self?.quizzes = quizzes ?? []
            } else {
                print("DEBUG: Get Quizzes Error In Home ViewModel \(String(describing: error?.localizedDescription))")            }
        }
    }
}
