//
//  SignUpSignInCoordinator.swift
//  Quizz Sphere
//
//  Created by Temur Chitashvili on 25.07.24.
//

import UIKit

protocol SignUpSignInCoordinatorProtocol: Coordinator {
    func showSignUpSignInVC()
}

class SignUpSignInCoordinator: SignUpSignInCoordinatorProtocol {
    var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var childCoordinators: [any Coordinator] = []
    
    var type: CoordinatorType { .login }
    
    func start() {
        showSignUpSignInVC()
    }
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    deinit {
        print("DEBUG: SignUpSignInCoordinator deinit")
    }
    
    func showSignUpSignInVC() {
        let signUpSignInViewModel: SignUpSignInViewModel = .init()
        let signUpSignInVC: SignUpSignInVC = .init(signUpSignInViewModel: signUpSignInViewModel)
        signUpSignInVC.didSendEventClosure = {[weak self] event in
            switch event {
            case .login:
                self?.finish()
            case .signup:
                self?.finish()
            }
        }
        
        navigationController.pushViewController(signUpSignInVC, animated: true)
    }
}
