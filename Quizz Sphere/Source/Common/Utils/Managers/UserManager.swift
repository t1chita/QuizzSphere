//
//  UserManager.swift
//  Quizz Sphere
//
//  Created by Temur Chitashvili on 07.08.24.
//

import Foundation

final class UserManager {
    static let shared = UserManager()
    
    var currentUser: User? {
        didSet { onUserChanged?() }
    }
    
    var onUserChanged: (() -> Void)?
    
    private init() {
        getUser()
    }
    
    func getUser() {
        FirebaseManager.shared.fetchUser { [weak self] user in
            guard let self = self else { return }
            
            self.currentUser = user
        }
    }
}
