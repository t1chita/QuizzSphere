//
//  User.swift
//  Quizz Sphere
//
//  Created by Temur Chitashvili on 25.07.24.
//

import Foundation

struct User: Codable, Identifiable {
    let id: String
    let nickName: String
    let email: String
    let avatarImageUrl: String
}
