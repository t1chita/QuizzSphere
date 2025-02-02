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
    
    var didSendEventClosure: ((QuestionsVC.Event, Int?, Int?, Int?) -> Void)?
    
    private lazy var timer: Timer = {
        let timer = Timer()
        return timer
    }()
    
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
        label.configure(with: viewModel.quiz.questions.first?.description)
        return label
    }()
    
    private lazy var answersCollectionView: UICollectionView = {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(AnswersCell.self, forCellWithReuseIdentifier: AnswersCell.identifier)
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    private lazy var timerBackgroundView: QSCard = {
        let view = QSCard()
        view.configure(backgroundColor: .pinkCard)
        return view
    }()
    
    private lazy var timerHorizontalStackView: QSHorizontalStackView = {
        let stackView = QSHorizontalStackView()
        return stackView
    }()
    
    private lazy var timerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "clock")
        imageView.tintColor = .blueCard
        return imageView
    }()
    
    private lazy var timerLabel: QSLabel = {
        let label = QSLabel()
        label.configure(with: "01:00",
                        fontType: .bold,
                        textAlignment: .right)
        return label
    }()
    
    private lazy var scoresBackgroundView: QSCard = {
        let view = QSCard()
        view.configure(backgroundColor: .pinkCard)
        return view
    }()
    
    private lazy var scoresHorizontalStackView: QSHorizontalStackView = {
        let stackView = QSHorizontalStackView()
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private lazy var scoresImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = .coins
        return imageView
    }()
    
    private lazy var scoresLabel: QSLabel = {
        let label = QSLabel()
        label.configure(with: "0 Points",
                        fontType: .bold,
                        textAlignment: .left)
        return label
    }()
    
    private lazy var areYouReadyStackViewCenterXConstraint: NSLayoutConstraint = { [weak self] in
        self!.areYouReadyStackView.centerXAnchor.constraint(equalTo: self!.view.centerXAnchor, constant: -1000)
    }()
    
    private lazy var questionLabelCenterXConstraint: NSLayoutConstraint = { [weak self] in
        self!.questionLabel.centerXAnchor.constraint(equalTo: self!.view.centerXAnchor, constant: 1000)
    }()
    
    private lazy var timerBackgroundViewTrailingConstraint: NSLayoutConstraint = { [weak self] in
        self!.timerBackgroundView.trailingAnchor.constraint(equalTo: self!.view.trailingAnchor, constant: 1000)
    }()
    
    private lazy var scoresBackgroundViewLeadingConstraint: NSLayoutConstraint = { [weak self] in
        self!.scoresBackgroundView.leadingAnchor.constraint(equalTo: self!.view.leadingAnchor, constant: -1000)
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        timerBackgroundView.round(corners: [.topLeft, .bottomLeft],
                                  radius: Constants.cardSmallCornerRadius)
        scoresBackgroundView.round(corners: [.bottomRight, .topRight],
                                   radius: Constants.cardSmallCornerRadius)
    }
        
    //MARK: - Setup UI
    private func setupUI() {
        setMainView()
        setAreYouReadyStackView()
        setQuestionLabel()
        setAnswersCollectionView()
        setTimerBackgroundView()
        setTimerHorizontalStackView()
        setScoresBackgroundView()
        setScoresHorizontalStackView()
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
            self?.didSendEventClosure?(.goBack, nil, nil, nil)
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
    
    private func setAnswersCollectionView() {
        view.addSubview(answersCollectionView)
        
        NSLayoutConstraint.activate([
            answersCollectionView.centerXAnchor.constraint(equalTo: questionLabel.centerXAnchor),
            answersCollectionView.widthAnchor.constraint(equalTo: questionLabel.widthAnchor),
            answersCollectionView.heightAnchor.constraint(equalToConstant: 200),
            answersCollectionView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 60),
        ])
    }
    
    private func setTimerBackgroundView() {
        view.addSubview(timerBackgroundView)
        
        NSLayoutConstraint.activate([
            timerBackgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            timerBackgroundViewTrailingConstraint,
            timerBackgroundView.heightAnchor.constraint(equalToConstant: 36),
            timerBackgroundView.widthAnchor.constraint(equalToConstant: 110),
        ])
    }
    
    private func setTimerHorizontalStackView() {
        timerBackgroundView.addSubview(timerHorizontalStackView)
        
        timerHorizontalStackView.addArrangedSubview(timerImageView)
        timerHorizontalStackView.addArrangedSubview(timerLabel)
        
        NSLayoutConstraint.activate([
            timerImageView.widthAnchor.constraint(equalTo: timerHorizontalStackView.heightAnchor),
            timerHorizontalStackView.topAnchor.constraint(equalTo: timerBackgroundView.topAnchor, constant: 6),
            timerHorizontalStackView.leadingAnchor.constraint(equalTo: timerBackgroundView.leadingAnchor, constant: 10),
            timerHorizontalStackView.trailingAnchor.constraint(equalTo: timerBackgroundView.trailingAnchor, constant: -10),
            timerHorizontalStackView.bottomAnchor.constraint(equalTo: timerBackgroundView.bottomAnchor, constant: -6),
        ])
    }
    
    private func setScoresBackgroundView() {
        view.addSubview(scoresBackgroundView)
        
        NSLayoutConstraint.activate([
            scoresBackgroundViewLeadingConstraint,
            scoresBackgroundView.topAnchor.constraint(equalTo: timerBackgroundView.bottomAnchor),
            scoresBackgroundView.heightAnchor.constraint(equalTo: timerBackgroundView.heightAnchor),
            scoresBackgroundView.widthAnchor.constraint(equalToConstant: 160),
        ])
    }
    
    private func setScoresHorizontalStackView() {
        scoresBackgroundView.addSubview(scoresHorizontalStackView)
        
        scoresHorizontalStackView.addArrangedSubview(scoresLabel)
        scoresHorizontalStackView.addArrangedSubview(scoresImageView)
        
        NSLayoutConstraint.activate([
            scoresImageView.widthAnchor.constraint(equalTo: scoresHorizontalStackView.heightAnchor),
            scoresHorizontalStackView.topAnchor.constraint(equalTo: scoresBackgroundView.topAnchor, constant: 6),
            scoresHorizontalStackView.leadingAnchor.constraint(equalTo: scoresBackgroundView.leadingAnchor, constant: 10),
            scoresHorizontalStackView.trailingAnchor.constraint(equalTo: scoresBackgroundView.trailingAnchor, constant: -10),
            scoresHorizontalStackView.bottomAnchor.constraint(equalTo: scoresBackgroundView.bottomAnchor, constant: -6),
        ])
    }
    
    
    
    //MARK: - Animations
    private func animateAreYouReadyStackView() {
        let newCenterXAnchorConstant: CGFloat = viewModel.userIsReadyToPlay ? -1000 : 0
        let labelNewCenterXAnchorConstant: CGFloat = viewModel.userIsReadyToPlay ?  0 : 1000
        let timerBackgroundViewNewTrailingAnchorConstant: CGFloat = viewModel.userIsReadyToPlay ? 0 : 1000
        let scoresBackgroundViewNewLeadingAnchorConstant: CGFloat = viewModel.userIsReadyToPlay ? 0 : -1000
        // Ensure consistent animation duration
        let animationDuration: TimeInterval = 0.3
        
        
        UIView.animate(withDuration: animationDuration,
                       delay: 0,
                       options: .curveEaseIn,
                       animations:{ [weak self] in
            
            self?.areYouReadyStackViewCenterXConstraint.constant = newCenterXAnchorConstant
            self?.questionLabelCenterXConstraint.constant = labelNewCenterXAnchorConstant
            self?.timerBackgroundViewTrailingConstraint.constant = timerBackgroundViewNewTrailingAnchorConstant
            self?.scoresBackgroundViewLeadingConstraint.constant = scoresBackgroundViewNewLeadingAnchorConstant
            self?.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    internal func animateQuestionAndAnswers(completion: @escaping () -> Void) {
        let animationDuration: TimeInterval = 0.5
        
        
        UIView.animate(withDuration: animationDuration,
                       delay: 0,
                       options: .curveEaseInOut) { [weak self] in
            self?.questionLabel.alpha = 0
            self?.answersCollectionView.alpha = 0
        } completion: { [weak self] _ in
            completion()
            UIView.animate(withDuration: animationDuration) {
                self?.questionLabel.alpha = 1
                self?.answersCollectionView.alpha = 1
            }
        }
    }
    
    //MARK: - Set Properties
    private func setTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(updateTimer),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    @objc private func updateTimer() {
        timerLabel.text = FormatterManager.shared.timeFormatted(viewModel.totalTime)
        if viewModel.totalTime > 0 {
            viewModel.totalTime -= 1
        } else if viewModel.totalTime == 0 {
            let question = viewModel.quiz.questions[viewModel.questionIndex]

            if viewModel.questionIndex != 11 {
                let nextQuestion = viewModel.quiz.questions[viewModel.questionIndex + 1]
                
                viewModel.setPropertiesIfAnswerIsNotLast()

                animateQuestionAndAnswers() { [weak self] in
                    self?.handleTimeIsUpLogic(withQuestion: nextQuestion.description,
                                              buttonTitle: "Next",
                                              questionIsLast: false)
                }
            } else {
                animateQuestionAndAnswers() { [weak self] in
                    self?.handleTimeIsUpLogic(withQuestion: question.description,
                                              buttonTitle: "Complete",
                                              questionIsLast: true)
                }
                
                if question.id == 11 {
                    timer.invalidate()
                }
            }
        } else {
            timer.invalidate()
        }
    }
}

//MARK: - Actions

extension QuestionsVC {
    private func handleReadyButton() {
        viewModel.toggleUserIsReadyToPlay()
        animateAreYouReadyStackView()
        setTimer()
    }
    
    internal func handleCorrectAnswerTap(withCoins coins: Int,
                                         question: String?,
                                         buttonTitle: String,
                                         questionIsLast: Bool) {
    
        let overLayer = QSDialogVC()
        overLayer.appear(onSender: self,
                         withTitle: LabelValues.Scenes.Questions.successfulPopupTitle,
                         message: LabelValues.Scenes.Questions.successfulPopupMessage + " " + String(viewModel.scoresOnQuiz) + " " + LabelValues.Scenes.Questions.points,
                         buttonTitle: buttonTitle)
        
        viewModel.answerIsCorrect(withCoins: coins)
        
        UserManager.shared.updateTotalScore(withScores: coins)
        
        scoresLabel.text = String(viewModel.totalScores) + " Points"
        
        if !questionIsLast {
            questionLabel.text = question
            answersCollectionView.reloadData()
        } else {
            overLayer.didSendEventClosure = { [weak self] event in
                switch event {
                case .hide:
                    self?.timer.invalidate()
                    self?.didSendEventClosure?(.quizCompleted, self?.viewModel.totalScores, self?.viewModel.completedQuestionsQuantity, self?.viewModel.quiz.quantity)
                }
            }
        }
    }
    
    private func handleTimeIsUpLogic(withQuestion question: String?,
                                     buttonTitle: String,
                                     questionIsLast: Bool) {
        
        let overLayer = QSDialogVC()
        overLayer.appear(onSender: self,
                         withTitle: LabelValues.Scenes.Questions.missedPopupTitle,
                         message: LabelValues.Scenes.Questions.missedPopupMessage,
                         buttonTitle: buttonTitle)
        
        if !questionIsLast {
            questionLabel.text = question
            answersCollectionView.reloadData()
        } else {
            overLayer.didSendEventClosure = { [weak self] event in
                switch event {
                case .hide:
                    self?.timer.invalidate()
                    self?.didSendEventClosure?(.quizCompleted, self?.viewModel.totalScores, self?.viewModel.completedQuestionsQuantity, self?.viewModel.quiz.quantity)
                }
            }
        }
    }
    
    internal func handleInCorrectAnswerTap(withQuestion question: String?,
                                           buttonTitle: String,
                                           questionIsLast: Bool) {
        
        let overLayer = QSDialogVC()
        overLayer.appear(onSender: self,
                         withTitle: LabelValues.Scenes.Questions.unSuccessfulPopupTitle,
                         message: LabelValues.Scenes.Questions.unSuccessfulPopupMessage,
                         buttonTitle: buttonTitle)
        
        if !questionIsLast {
            questionLabel.text = question
            answersCollectionView.reloadData()
        } else {
            overLayer.didSendEventClosure = { [weak self] event in
                switch event {
                case .hide:
                    self?.timer.invalidate()
                    self?.didSendEventClosure?(.quizCompleted, self?.viewModel.totalScores, self?.viewModel.completedQuestionsQuantity, self?.viewModel.quiz.quantity)
                }
            }
        }
    }
    
    internal func handleQuizCompletion(isCorrect: Bool, coins: Int, question: String?) {
        if isCorrect {
            handleCorrectAnswerTap(withCoins: coins,
                                   question: question,
                                   buttonTitle: LabelValues.Scenes.Questions.complete,
                                   questionIsLast: true)
        } else {
            handleInCorrectAnswerTap(withQuestion: question,
                                     buttonTitle: LabelValues.Scenes.Questions.complete,
                                     questionIsLast: true)
        }
    }
}

extension QuestionsVC {
    enum Event {
        case goBack
        case quizCompleted
    }
    
    enum Constants {
        static let buttonSmallCornerRadius: CGFloat = 10
        static let cardSmallCornerRadius: CGFloat = 12
    }
}

