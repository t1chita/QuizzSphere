//
//  HomeVC.swift
//  Quizz Sphere
//
//  Created by Temur Chitashvili on 25.07.24.
//

import UIKit

final class HomeVC: UIViewController {
    //MARK: - Properties
    var homeViewModel: HomeViewModel
    
    var didSendEventClosure: ((HomeVC.Event, Quiz) -> Void)?
    
    private var quizSheetTopConstraint: NSLayoutConstraint?
    
    //MARK: - UIComponents
    private lazy var greetingCardView: QSCard = {
        let view = QSCard()
        view.configure(withCornerRadius: Constants.cardSmallCornerRadius,
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
        label.configure(with: "",
                        fontType: .bold,
                        textAlignment: .left,
                        textColor: .primaryText)
        return label
    }()
    
    private lazy var currentQuizzCard: QSCard = {
        let card = QSCard()
        card.configure(withCornerRadius: Constants.cardSmallCornerRadius,
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
    
    private lazy var quizSheet: QSCard = {
        let view = QSCard()
        view.configure(backgroundColor: .blueCard)
        return view
    }()
    
    private lazy var quizSheetHeaderStackView: QSHorizontalStackView = {
        let stackView = QSHorizontalStackView()
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private lazy var quizSheetTitleLabel: QSLabel = {
        let label = QSLabel()
        label.configure(with: LabelValues.Scenes.Home.liveQuizzes,
                        fontType: .bold,
                        textAlignment: .left,
                        textColor: .primaryText)
        return label
    }()
    
    private lazy var seeAllButton: QSButton = {
        let button = QSButton()
        button.configure(with: LabelValues.Scenes.Home.seeAll,
                         fontType: .regular,
                         contentAlignment: .right,
                         textColor: .pinkCard,
                         cornerRadius: 0)
        return button
    }()
    
    private lazy var quizTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(QuizCell.self,
                           forCellReuseIdentifier: QuizCell.identifier)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.rowHeight = 100
        return tableView
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
        setupBindings()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        quizSheet.round(corners: [.topLeft, .topRight],
                        radius: Constants.cardMediumCornerRadius)
    }
    //MARK: - Delegates
    
    //MARK: - Setup UI
    private func setupUI() {
        setupMainView()
        
        setGreetingCardView()
        setGreetingHorizontalStackView()
        setGreetingHorizontalStackViewContent()
        
        setCurrentQuizzCard()
        setCurrentQuizzHorizontalStackView()
        setCurrentQuizzHorizontalStackViewContent()
        setCurrentQuizzVerticalStackView()
        setProgressCircle()
        
        setQuizSheet()
        setQuizSheetHeaderStackView()
        setQuizTableView()
    }
    
    //MARK: - Set UI Components
    private func setupMainView() {
        view.backgroundColor = .customBackground
    }
    
    private func setGreetingCardView() {
        view.addSubview(greetingCardView)
        
        NSLayoutConstraint.activate([
            greetingCardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            greetingCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            greetingCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
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
        view.addSubview(currentQuizzCard)
        
        NSLayoutConstraint.activate([
            currentQuizzCard.topAnchor.constraint(equalTo: greetingCardView.bottomAnchor, constant: 40),
            currentQuizzCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            currentQuizzCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
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
    
    private func setQuizSheet() {
        view.addSubview(quizSheet)
        
        quizSheetTopConstraint = quizSheet.topAnchor.constraint(equalTo: currentQuizzCard.bottomAnchor, constant: 140)
        quizSheetTopConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            quizSheet.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            quizSheet.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            quizSheet.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func setQuizSheetHeaderStackView() {
        quizSheet.addSubview(quizSheetHeaderStackView)
        
        quizSheetHeaderStackView.addArrangedSubview(quizSheetTitleLabel)
        quizSheetHeaderStackView.addArrangedSubview(seeAllButton)
        
        seeAllButton.didSendEventClosure = {[weak self] in
            self?.handleSeeAllButton()
        }
        
        NSLayoutConstraint.activate([
            quizSheetHeaderStackView.topAnchor.constraint(equalTo: quizSheet.topAnchor, constant: 24),
            quizSheetHeaderStackView.leadingAnchor.constraint(equalTo: quizSheet.leadingAnchor, constant: 24),
            quizSheetHeaderStackView.trailingAnchor.constraint(equalTo: quizSheet.trailingAnchor, constant: -24),
            quizSheetHeaderStackView.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    private func setQuizTableView() {
        quizSheet.addSubview(quizTableView)
        
        NSLayoutConstraint.activate([
            quizTableView.topAnchor.constraint(equalTo: quizSheetHeaderStackView.bottomAnchor, constant: 20),
            quizTableView.leadingAnchor.constraint(equalTo: quizSheet.leadingAnchor),
            quizTableView.trailingAnchor.constraint(equalTo: quizSheet.trailingAnchor),
            quizTableView.bottomAnchor.constraint(equalTo: quizSheet.bottomAnchor),
        ])
    }
    
    //MARK: - Animations
    private func animateQuizSheet() {
        //TODO: - Fix Animation
        quizSheetTopConstraint?.constant = homeViewModel.quizSheetAnimate ? -50 : 140
        
        seeAllButton.setTitle(homeViewModel.quizSheetAnimate ? LabelValues.Scenes.Home.seeLess : LabelValues.Scenes.Home.seeAll,
                              for: .normal)
        
        UIView.animate(withDuration: 0.3,
                       animations: {[weak self] in
            
            self?.view.layoutIfNeeded()
        })
    }
}

extension HomeVC {
    private func handleSeeAllButton() {
        homeViewModel.toggleQuizSheetAnimate()
        animateQuizSheet()
    }
}

extension HomeVC {
    func setupBindings() {
        homeViewModel.onQuizzesChanged = { [weak self] in
            DispatchQueue.main.async { [weak self] in
                self?.quizTableView.reloadData()
            }
        }
        
        UserManager.shared.onUserChanged = { [weak self] in
            
            guard let imageUrl = URL(string: UserManager.shared.currentUser!.avatarImageUrl) else { return }
            
            DispatchQueue.main.async { [weak self] in
                self?.userNameLabel.text = UserManager.shared.currentUser?.nickName
                self?.userProfileImage.loadImage(from: imageUrl)
            }
        }
    }
}

extension HomeVC {
    enum Event {
        case quizTapped
    }
    
    enum Constants {
        static let cardSmallCornerRadius: CGFloat = 10
        static let cardMediumCornerRadius: CGFloat = 30
    }
}
