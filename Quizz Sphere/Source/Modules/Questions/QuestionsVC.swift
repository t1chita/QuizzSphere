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
    
    var didSendEventClosure: ((QuestionsVC.Event) -> Void)?
    
    //MARK: - UIComponents
    private lazy var areYouReadyStackView: QSVerticalStackView = {
        let stackView = QSVerticalStackView()
        stackView.spacing = 20
        return stackView
    }()
    
    private lazy var areYouReadyLabel: QSLabel = {
        let label = QSLabel()
        label.configure(with: LabelValues.Scenes.Questions.areYouReady)
        return label
    }()
    
    private lazy var readyButton: QSButton = {
        let button = QSButton()
        button.configure(with: LabelValues.Scenes.Questions.ready,
                         fontType: .regular,
                         backgroundColor: .clear,
                         cornerRadius: Constants.buttonSmallCornerRadius,
                         borderWidth: 2,
                         borderColor: .plusPoint)
        return button
    }()
    
    private lazy var goBackButton: QSButton = {
        let button = QSButton()
        button.configure(with: LabelValues.Scenes.Questions.goBack,
                         fontType: .regular,
                         backgroundColor: .clear,
                         cornerRadius: Constants.buttonSmallCornerRadius,
                         borderWidth: 2,
                         borderColor: .minusPoint)
        return button
    }()
    
    private lazy var questionLabel: QSLabel = {
        let label = QSLabel()
        label.configure(with: viewModel.quiz.questions?.first?.description)
        return label
    }()
    
    private lazy var answersVerticalStackView: QSVerticalStackView = {
        let stackView = QSVerticalStackView()
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var topHorizontalStackView: QSHorizontalStackView = {
        let stackView = QSHorizontalStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var bottomHorizontalStackView: QSHorizontalStackView = {
        let stackView = QSHorizontalStackView()
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var answerFirstButton: QSButton = {
        let button = QSButton()
        button.configure(with: viewModel.quiz.questions?.first?.correctAnswer,
                         fontType: .regular,
                         backgroundColor: .blueCard,
                         cornerRadius: Constants.buttonSmallCornerRadius)
        return button
    }()
        
    private lazy var answerSecondButton: QSButton = {
        let button = QSButton()
        button.configure(with: viewModel.quiz.questions?.first?.incorrectAnswerOne,
                         fontType: .regular,
                         backgroundColor: .blueCard,
                         cornerRadius: Constants.buttonSmallCornerRadius)
        return button
    }()
        
    private lazy var answerThirdButton: QSButton = {
        let button = QSButton()
        button.configure(with: viewModel.quiz.questions?.first?.incorrectAnswerTwo,
                         fontType: .regular,
                         backgroundColor: .blueCard,
                         cornerRadius: Constants.buttonSmallCornerRadius)
        return button
    }()
        
    private lazy var answerFourthButton: QSButton = {
        let button = QSButton()
        button.configure(with: viewModel.quiz.questions?.first?.incorrectAnswerThree,
                         fontType: .regular,
                         backgroundColor: .blueCard,
                         cornerRadius: Constants.buttonSmallCornerRadius)
        return button
    }()
    
    private lazy var areYouReadyStackViewCenterXConstraint: NSLayoutConstraint = { [weak self] in
        return self!.areYouReadyStackView.centerXAnchor.constraint(equalTo: self!.view.centerXAnchor, constant: -1000)
    }()
    
    private lazy var questionLabelCenterXConstraint: NSLayoutConstraint = { [weak self] in
        return self!.questionLabel.centerXAnchor.constraint(equalTo: self!.view.centerXAnchor, constant: 1000)
    }()
    
    //MARK: - Initialisation
    init(viewModel: QuestionsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycles
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        animateAreYouReadyStackView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - Delegates
    
    //MARK: - Setup UI
    private func setupUI() {
        setMainView()
        setAreYouReadyStackView()
        setQuestionLabel()
        setAnswersVerticalStackView()
    }
    
    //MARK: - Set UI Components
    private func setMainView() {
        view.backgroundColor = .customBackground
        title = viewModel.quiz.name
        navigationController?.navigationBar.topItem?.title = " "
    }
    
    private func setAreYouReadyStackView() {
        view.addSubview(areYouReadyStackView)
        
        areYouReadyStackView.addArrangedSubview(areYouReadyLabel)
        areYouReadyStackView.addArrangedSubview(readyButton)
        areYouReadyStackView.addArrangedSubview(goBackButton)
        
        readyButton.addAction(UIAction(title: "Handle Ready Button", handler: { [weak self] _ in
            self?.handleReadyButton()
        }), for: .touchUpInside)
        
        goBackButton.addAction(UIAction(title: "Go Back To Home Page", handler: { [weak self] _ in
            self?.didSendEventClosure?(.goBack)
        }), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            areYouReadyStackViewCenterXConstraint,
            areYouReadyStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    private func setQuestionLabel() {
        view.addSubview(questionLabel)
        
        NSLayoutConstraint.activate([
            questionLabelCenterXConstraint,
            questionLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            questionLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -48),
        ])
    }
    
    private func setAnswersVerticalStackView() {
        view.addSubview(answersVerticalStackView)
        
        setTopHorizontalStackView()
        
        NSLayoutConstraint.activate([
            answersVerticalStackView.centerXAnchor.constraint(equalTo: questionLabel.centerXAnchor),
            answersVerticalStackView.widthAnchor.constraint(equalTo: questionLabel.widthAnchor),
            answersVerticalStackView.heightAnchor.constraint(equalToConstant: 200),
            answersVerticalStackView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 60),
        ])
    }
    
    private func setTopHorizontalStackView() {
        answersVerticalStackView.addArrangedSubview(topHorizontalStackView)
        topHorizontalStackView.addArrangedSubview(answerFirstButton)
        topHorizontalStackView.addArrangedSubview(answerSecondButton)
        
        answersVerticalStackView.addArrangedSubview(bottomHorizontalStackView)
        bottomHorizontalStackView.addArrangedSubview(answerThirdButton)
        bottomHorizontalStackView.addArrangedSubview(answerFourthButton)
    }
    
    //MARK: - Animations
    private func animateAreYouReadyStackView() {
        let newCenterXAnchorConstant: CGFloat = viewModel.userIsReadyToPlay ? -1000 : 0
        // Ensure consistent animation duration
        let animationDuration: TimeInterval = 0.3
        
        
        UIView.animate(withDuration: animationDuration,
                       delay: 0,
                       options: .curveEaseIn,
                       animations:{ [weak self] in
            
            self?.areYouReadyStackViewCenterXConstraint.constant = newCenterXAnchorConstant
            self?.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func animateQuestionLabelCenterXConstraint() {
        let newCenterXAnchorConstant: CGFloat = viewModel.userIsReadyToPlay ?  0 : 1000
        
        let animationDuration: TimeInterval = 0.3
        
        UIView.animate(withDuration: animationDuration,
                       delay: 0,
                       options: .curveEaseIn,
                       animations:{ [weak self] in
            
            self?.questionLabelCenterXConstraint.constant = newCenterXAnchorConstant
            self?.view.layoutIfNeeded()
        }, completion: nil)
    }
}

//MARK: - Actions

extension QuestionsVC {
    private func handleReadyButton() {
        viewModel.toggleUserIsReadyToPlay()
        animateAreYouReadyStackView()
        animateQuestionLabelCenterXConstraint()
    }
}

extension QuestionsVC {
    enum Event {
        case goBack
    }
    
    enum Constants {
        static let buttonSmallCornerRadius: CGFloat = 10
    }
}
