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
                    avatarImageUrl: String,
                    completion: @escaping (Bool) -> Void) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            let user = User(id: result.user.uid, nickName: nickName, email: email, avatarImageUrl: avatarImageUrl)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            completion(true)
        } catch {
            completion(false)
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    func signIn(withEmail email: String,
                password: String,
                completion:@escaping (Bool) -> Void) async throws {
        do {
            try await Auth.auth().signIn(withEmail: email, password: password)
            completion(true)
        } catch {
            completion(false)
            print("DEBUG: Failed to sign in user with error \(error.localizedDescription)")
        }
    }
    
    func getDocuments<T: Decodable>(from collection: String,
                                    completion: @escaping ([T]?, Error?) -> Void) {
        Firestore.firestore().collection(collection).getDocuments { (snapshot, error) in
            
            if let error = error {
                print("DEBUG: Error getting documents from \(collection): \(error.localizedDescription)")
                completion(nil, error)
            } else {
                var documents: [T] = []
                if let snapshot = snapshot {
                    for document in snapshot.documents {
                        do {
                            let doc = try document.data(as: T.self)
                            documents.append(doc)
                        } catch {
                            print("DEBUG: Error decoding document from \(collection): \(error.localizedDescription)")
                        }
                    }
                }
                completion(documents, nil)
            }
        }
    }

    
    func fetchUser(completion: @escaping (User) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore().collection("users").document(uid).getDocument { (documentSnapshot, error) in
            
            
            guard let document = documentSnapshot else {
                print("DEBUG: Error fetching user data: \(error?.localizedDescription ?? "")")
                return
            }
            
            do {
                let user = try document.data(as: User.self)
                completion(user)
            } catch {
                print("DEBUG: Error decoding user data: \(error.localizedDescription)")
            }
        }
    }
}
