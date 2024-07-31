//
//  FirebaseManager.swift
//  Quizz Sphere
//
//  Created by Temur Chitashvili on 28.07.24.
//

import Foundation
import Firebase
import FirebaseFirestore

final class FirebaseManager {
    static let shared = FirebaseManager()
    
    private init() { }
    
    func createUser(withEmail email: String,
                    nickName: String,
                    password: String,
                    completion: @escaping (Bool) -> Void) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            let user = User(id: result.user.uid, nickName: nickName, email: email)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            completion(true)
        } catch {
            completion(false)
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }
    }
}
