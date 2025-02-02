//
//  GameManager.swift
//  Quizz Sphere
//
//  Created by Temur Chitashvili on 13.08.24.
//

import Foundation

final class GameManager {
    static let shared = GameManager()
    
    private init() { }
    
    func getPoints(timeRemaining time: Int) -> Int {
        return time * 100 / 60
    }
}
