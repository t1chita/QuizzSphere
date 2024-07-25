//
//  ProfileVC.swift
//  Quizz Sphere
//
//  Created by Temur Chitashvili on 25.07.24.
//

import UIKit

class ProfileVC: UIViewController {
    //MARK: - Properties
    private var profileViewModel: ProfileViewModel
    //MARK: - UIComponents
    
    //MARK: - Initialisation
    init(profileViewModel: ProfileViewModel) {
        self.profileViewModel = profileViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycles
    
    //MARK: - Delegates
    
    //MARK: - Setup UI
    
    //MARK: - Set UI Components

}
