//
//  Quiz.swift
//  Quizz Sphere
//
//  Created by Temur Chitashvili on 05.08.24.
//

import Foundation

struct Quiz: Codable {
    let id: String
    let imageUrl: String
    let name: String
    let category: String
    let quantity: Int
    let questions: [Question]
}

struct Question: Codable {
    let id: Int?
    let description: String
    let answers: [Answer]
}

struct Answer: Codable {
    let description: String
    let isCorrect: Bool
}
