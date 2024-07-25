//
//  LeaderBoardVC.swift
//  Quizz Sphere
//
//  Created by Temur Chitashvili on 25.07.24.
//

import UIKit

class LeaderBoardVC: UIViewController {
    //MARK: - Properties
    private var leaderBoardViewModel: LeaderBoardViewModel
    //MARK: - UIComponents

    //MARK: - Initialisation
    init(leaderBoardViewModel: LeaderBoardViewModel) {
        self.leaderBoardViewModel = leaderBoardViewModel
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
