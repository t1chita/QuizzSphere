//
//  HomeVC.swift
//  Quizz Sphere
//
//  Created by Temur Chitashvili on 25.07.24.
//

import UIKit
import Firebase

class HomeVC: UIViewController {
    //MARK: - Properties
    private var homeViewModel: HomeViewModel
    
    //MARK: - UIComponents
    
    //MARK: - Initialisation
    init(homeViewModel: HomeViewModel) {
        self.homeViewModel = homeViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIButton()
        view.addSubview(button)
        button.setTitle("SignOut", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        button.heightAnchor.constraint(equalToConstant: 100).isActive = true
        button.addAction(UIAction(handler: {[weak self] _ in
            do {
                try Auth.auth().signOut()
            } catch {
                print("DEBUG: Cannot sign out user from backend")
            }
        }), for: .touchUpInside)
    }
    //MARK: - Delegates
    
    //MARK: - Setup UI
    
    //MARK: - Set UI Components

}
