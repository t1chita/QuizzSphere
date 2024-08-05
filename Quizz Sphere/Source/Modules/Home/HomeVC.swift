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
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var containerView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private lazy var greetingCardView: QSCard = {
        let view = QSCard()
        view.configure(withCornerRadius: Constants.cardCornerRadius,
                       backgroundColor: .blueCard)
        return view
    }()
    
    private lazy var greetingHorizontalStackView: QSHorizontalStackView = {
        let stackView = QSHorizontalStackView()
        return stackView
    }()
    
    private lazy var greetingVerticalStackView: QSVerticalStackView = {
        let stackView = QSVerticalStackView()
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private lazy var userProfileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "person.circle.fill")
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var greetingTextLabel: QSLabel = {
        let label = QSLabel()
        label.configure(with: GreetingLogic.shared.greetingText(),
                        fontType: .semiBold,
                        textAlignment: .left,
                        textColor: .secondaryText)
        return label
    }()
    
    private lazy var userNameLabel: QSLabel = {
        let label = QSLabel()
        label.configure(with: "Temur Chitashvili",
                        fontType: .bold,
                        textAlignment: .left,
                        textColor: .primaryText)
        return label
    }()
    
    private lazy var currentQuizzCard: QSCard = {
        let card = QSCard()
        card.configure(withCornerRadius: Constants.cardCornerRadius,
                       backgroundColor: .pinkCard)
        return card
    }()
    
    private lazy var currentQuizzHorizontalStackView: QSHorizontalStackView = {
        let stackView = QSHorizontalStackView()
        return stackView
    }()
    
    private lazy var currentQuizzVerticalStackView: QSVerticalStackView = {
        let stackView = QSVerticalStackView()
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    
    private lazy var currentQuizzLabel: QSLabel = {
        let label = QSLabel()
        label.configure(with: LabelValues.Scenes.Home.currentQuizz,
                        fontType: .regular,
                        textAlignment: .left,
                        textColor: .blueCard)
        return label
    }()
    
    private lazy var currentQuizzName: QSLabel = {
        let label = QSLabel()
        label.configure(with: "Math And Science Quizz",
                        fontType: .semiBold,
                        textAlignment: .left,
                        textColor: .primaryText)
        return label
    }()
    
    private lazy var progressCircle: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 25
        view.backgroundColor = .customBackground
        return view
    }()
    
    private lazy var progressPercentLabel: QSLabel = {
        let label = QSLabel()
        label.configure(with: "65%",
                        fontType: .semiBold,
                        textAlignment: .center,
                        textColor: .primaryText)
        return label
    }()
    
    
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
        setupUI()
        addHideKeyboardTapGestureRecogniser()
    }
    
    //MARK: - Delegates
    
    //MARK: - Setup UI
    private func setupUI() {
        setupMainView()
        
        setScrollView()
        setContentView()
        
        setGreetingCardView()
        setGreetingHorizontalStackView()
        setGreetingHorizontalStackViewContent()
        
        setCurrentQuizzCard()
        setCurrentQuizzHorizontalStackView()
        setCurrentQuizzHorizontalStackViewContent()
        setCurrentQuizzVerticalStackView()
        setProgressCircle()
    }
    
    //MARK: - Set UI Components
    private func setupMainView() {
        view.backgroundColor = .customBackground
    }
    
    private func setScrollView() {
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func setContentView() {
        scrollView.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalToConstant: view.frame.width),
            containerView.heightAnchor.constraint(equalToConstant:view.frame.height),
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    private func setGreetingCardView() {
        containerView.addSubview(greetingCardView)
        
        NSLayoutConstraint.activate([
            greetingCardView.topAnchor.constraint(equalTo: containerView.topAnchor),
            greetingCardView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            greetingCardView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            greetingCardView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func setGreetingHorizontalStackView() {
        greetingCardView.addSubview(greetingHorizontalStackView)
        
        NSLayoutConstraint.activate([
            greetingHorizontalStackView.topAnchor.constraint(equalTo: greetingCardView.topAnchor, constant: 10),
            greetingHorizontalStackView.leadingAnchor.constraint(equalTo: greetingCardView.leadingAnchor, constant: 10),
            greetingHorizontalStackView.trailingAnchor.constraint(equalTo: greetingCardView.trailingAnchor, constant: -10),
            greetingHorizontalStackView.bottomAnchor.constraint(equalTo: greetingCardView.bottomAnchor, constant: -10),
        ])
    }
    
    private func setGreetingHorizontalStackViewContent() {
        greetingVerticalStackView.addArrangedSubview(greetingTextLabel)
        greetingVerticalStackView.addArrangedSubview(userNameLabel)
        
        greetingHorizontalStackView.addArrangedSubview(greetingVerticalStackView)
        greetingHorizontalStackView.addArrangedSubview(userProfileImage)
        
        NSLayoutConstraint.activate([
            userProfileImage.widthAnchor.constraint(equalToConstant: 60),
            userProfileImage.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    private func setCurrentQuizzCard() {
        containerView.addSubview(currentQuizzCard)
        
        NSLayoutConstraint.activate([
            currentQuizzCard.topAnchor.constraint(equalTo: greetingCardView.bottomAnchor, constant: 40),
            currentQuizzCard.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            currentQuizzCard.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            currentQuizzCard.heightAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    private func setCurrentQuizzHorizontalStackView() {
        currentQuizzCard.addSubview(currentQuizzHorizontalStackView)
        
        NSLayoutConstraint.activate([
            currentQuizzHorizontalStackView.topAnchor.constraint(equalTo: currentQuizzCard.topAnchor, constant: 20),
            currentQuizzHorizontalStackView.leadingAnchor.constraint(equalTo: currentQuizzCard.leadingAnchor, constant: 20),
            currentQuizzHorizontalStackView.trailingAnchor.constraint(equalTo: currentQuizzCard.trailingAnchor, constant: -20),
            currentQuizzHorizontalStackView.bottomAnchor.constraint(equalTo: currentQuizzCard.bottomAnchor, constant: -20),
        ])
    }
    
    private func setCurrentQuizzHorizontalStackViewContent() {
        currentQuizzHorizontalStackView.addArrangedSubview(currentQuizzVerticalStackView)
        currentQuizzHorizontalStackView.addArrangedSubview(progressCircle)
        
        
    }
    
    private func setCurrentQuizzVerticalStackView() {
        currentQuizzVerticalStackView.addArrangedSubview(currentQuizzLabel)
        currentQuizzVerticalStackView.addArrangedSubview(currentQuizzName)
    }
    
    private func setProgressCircle() {
        progressCircle.addSubview(progressPercentLabel)

        NSLayoutConstraint.activate([
            progressCircle.widthAnchor.constraint(equalToConstant: 50),
            progressCircle.heightAnchor.constraint(equalToConstant: 50),
            progressPercentLabel.centerXAnchor.constraint(equalTo: progressCircle.centerXAnchor),
            progressPercentLabel.centerYAnchor.constraint(equalTo: progressCircle.centerYAnchor),
        ])
    }
}

extension HomeVC {
    enum Constants {
        static let cardCornerRadius: CGFloat = 10
    }
}
