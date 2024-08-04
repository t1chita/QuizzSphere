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
    
    private lazy var greetingCardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = Constants.greetingCardCornerRadius
        view.layer.masksToBounds = false
        view.backgroundColor = .customCardColors
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
        NSLayoutConstraint.activate([
            userProfileImage.widthAnchor.constraint(equalToConstant: 60),
            userProfileImage.heightAnchor.constraint(equalToConstant: 60),
        ])
        greetingHorizontalStackView.addArrangedSubview(userProfileImage)
    }
}

extension HomeVC {
    enum Constants {
        static let greetingCardCornerRadius: CGFloat = 10
    }
}
