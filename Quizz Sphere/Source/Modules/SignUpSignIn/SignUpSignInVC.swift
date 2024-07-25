//
//  SignUpSignInVC.swift
//  Quizz Sphere
//
//  Created by Temur Chitashvili on 25.07.24.
//

import UIKit

class SignUpSignInVC: UIViewController {
    //MARK: - Properties
    private var signUpSignInViewModel: SignUpSignInViewModel
    
    var didSendEventClosure: ((SignUpSignInVC.Event) -> Void)?

    //MARK: - UIComponents
    private let loginButton: UIButton = {
          let button = UIButton()
          button.setTitle("Login", for: .normal)
          button.backgroundColor = .systemBlue
          button.setTitleColor(.white, for: .normal)
          button.layer.cornerRadius = 8.0
          
          return button
      }()
    //MARK: - Initialisation
    init(signUpSignInViewModel: SignUpSignInViewModel) {
        self.signUpSignInViewModel = signUpSignInViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
               
               view.addSubview(loginButton)

               loginButton.translatesAutoresizingMaskIntoConstraints = false

               NSLayoutConstraint.activate([
                   loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                   loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                   loginButton.widthAnchor.constraint(equalToConstant: 200),
                   loginButton.heightAnchor.constraint(equalToConstant: 50)
               ])
               
        loginButton.addAction(UIAction(handler: {[weak self] _ in
            self?.didSendEventClosure?(.login)
        }), for: .touchUpInside)
    }
    //MARK: - Delegates
    
    //MARK: - Setup UI
    
    //MARK: - Set UI Components
}

extension SignUpSignInVC {
    enum Event {
        case login
    }
}
