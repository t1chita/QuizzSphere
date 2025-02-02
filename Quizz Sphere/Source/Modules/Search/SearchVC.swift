//
//  SearchVC.swift
//  Quizz Sphere
//
//  Created by Temur Chitashvili on 18.08.24.
//

import UIKit

final class SearchVC: UIViewController {
    //MARK: - Properties
    let viewModel: SearchViewModel
    
    //MARK: - UIComponents
    
    //MARK: - Initialisation
    init(viewModel: SearchViewModel) {
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
        title = LabelValues.Scenes.Search.title
        view.backgroundColor = .customBackground
    }
}
