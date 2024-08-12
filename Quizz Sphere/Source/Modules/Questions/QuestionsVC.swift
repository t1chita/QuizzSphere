//
//  QuestionsVC.swift
//  Quizz Sphere
//
//  Created by Temur Chitashvili on 12.08.24.
//

import UIKit

final class QuestionsVC: UIViewController {
    //MARK: - Properties
    let viewModel: QuestionsViewModel
    //MARK: - UIComponents
    
    //MARK: - Initialisation
    init(viewModel: QuestionsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - Delegates
    
    //MARK: - Setup UI
    private func setupUI() {
        setMainView()
    }
    
    //MARK: - Set UI Components
    private func setMainView() {
        view.backgroundColor = .customBackground
        title = viewModel.quiz.name
    }
}
