//
//  MainCoordinator.swift
//  Quizz Sphere
//
//  Created by Temur Chitashvili on 25.07.24.
//

import UIKit
import Firebase

protocol AppCoordinatorProtocol: Coordinator {
    func showLoginFlow()
    func showMainFlow()
}

class AppCoordinator: AppCoordinatorProtocol {
    weak var finishDelegate: CoordinatorFinishDelegate? = nil
    
    var navigationController: UINavigationController
    
    var childCoordinators = [Coordinator]()
    
    var type: CoordinatorType { .app }
        
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.setNavigationBarHidden(true, animated: true)
    }

    func start() {
        if Auth.auth().currentUser == nil {
            showLoginFlow()
        } else {
            showMainFlow()
        }
    }
        
    func showLoginFlow() {
        let loginCoordinator = SignUpSignInCoordinator.init(navigationController)
        loginCoordinator.finishDelegate = self
        loginCoordinator.start()
        childCoordinators.append(loginCoordinator)
    }
    
    func showMainFlow() {
        let tabCoordinator = TabBarCoordinator.init(navigationController)
          tabCoordinator.finishDelegate = self
          tabCoordinator.start()
          childCoordinators.append(tabCoordinator)
    }
}

extension AppCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
           childCoordinators = childCoordinators.filter({ $0.type != childCoordinator.type })

           switch childCoordinator.type {
           case .tab:
               navigationController.viewControllers.removeAll()

               showLoginFlow()
           case .login:
               navigationController.viewControllers.removeAll()

               showMainFlow()
           default:
               break
           }
       }
}
