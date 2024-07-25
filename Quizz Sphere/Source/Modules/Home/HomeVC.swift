//
//  HomeVC.swift
//  Quizz Sphere
//
//  Created by Temur Chitashvili on 25.07.24.
//

import UIKit

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
    
    //MARK: - Delegates
    
    //MARK: - Setup UI
    
    //MARK: - Set UI Components

}
