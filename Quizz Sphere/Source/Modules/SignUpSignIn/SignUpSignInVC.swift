//
//  SignUpSignInVC.swift
//  Quizz Sphere
//
//  Created by Temur Chitashvili on 25.07.24.
//

import UIKit

class SignUpSignInVC: UIViewController {
    //MARK: - Properties
    private var signUpSignInViewModel: SignUpSignInViewModel
    
    var didSendEventClosure: ((SignUpSignInVC.Event) -> Void)?
    
    //MARK: - UIComponents
    private lazy var titleLabel: QSLabel = {
        let label = QSLabel()
        label.configure(with: LabelValues.Scenes.SignInSignUp.logIn)
        return label
    }()
    
    private lazy var segmentedControlContainerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .clear
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(frame: .zero)
        //Insert Segments
        segmentedControl.insertSegment(withTitle: LabelValues.Scenes.SignInSignUp.logIn,
                                       at: 0,
                                       animated: false)
        segmentedControl.insertSegment(withTitle: LabelValues.Scenes.SignInSignUp.signUp,
                                       at: 1,
                                       animated: false)
        
        //Set Segments Titles
        segmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel,
            NSAttributedString.Key.font:  AppConstants.Font.EBGaramond.bold as Any], for: .normal)
        
        segmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.customCardColors,
            NSAttributedString.Key.font: AppConstants.Font.EBGaramond.bold as Any], for: .selected)
        
        //Set SegmentedControl Colors To Clear
        segmentedControl.selectedSegmentTintColor = .clear
        segmentedControl.backgroundColor = .clear
        
        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.addAction(UIAction(handler: {[weak self] _ in
            self?.segmentedValueChanged()
        }), for: .valueChanged)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    private lazy var bottomUnderlineView: UIView = {
        let underlineView = UIView()
        underlineView.backgroundColor = .customCardColors
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        return underlineView
    }()
    
    private lazy var leadingDistanceConstraint: NSLayoutConstraint = {
        return bottomUnderlineView.leftAnchor.constraint(equalTo: segmentedControl.leftAnchor)
    }()
    
    private lazy var signInFormStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = Constants.verticalStackViewSpacing
        return stackView
    }()
    
    private lazy var emailTextField: QSTextField = {
        let emailTextField = QSTextField()
        emailTextField.configure(withPadding: .left(Constants.textFieldPadding),
                                 iconName: AppConstants.Images.SystemNames.emailIcon,
                                 placeHolder: LabelValues.Scenes.SignInSignUp.emailPlaceHolder)
        return emailTextField
    }()
    
    private lazy var passwordTextField: QSTextField = {
        let passwordTextField = QSTextField()
        passwordTextField.configure(withPadding: .left(Constants.textFieldPadding),
                                    iconName: AppConstants.Images.SystemNames.passwordIcon,
                                    placeHolder: LabelValues.Scenes.SignInSignUp.passwordPlaceHolder)
        return passwordTextField
    }()
    
    private lazy var passwordFunctionalityStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = Constants.horizontalStackViewSpacing
        return stackView
    }()
    
    private lazy var checkBoxButton: QSCheckBoxButton = {
        let button = QSCheckBoxButton()
        button.configure(withCornerRadius: Constants.checkBoxCornerRadius)
        return button
    }()
    
    private lazy var rememberPasswordLabel: QSLabel = {
        let label = QSLabel()
        label.configure(with: LabelValues.Scenes.SignInSignUp.rememberPassword,
                        fontType: .regular,
                        textAlignment: .left)
        return label
    }()
    
    private lazy var forgetPasswordLabel: QSLabel = {
        let label = QSLabel()
        label.configure(with: LabelValues.Scenes.SignInSignUp.forgotPassword,
                        fontType: .regular,
                        textAlignment: .right,
                        textColor: .blue)
        return label
    }()
    //MARK: - Initialisation
    init(signUpSignInViewModel: SignUpSignInViewModel) {
        self.signUpSignInViewModel = signUpSignInViewModel
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
        setUpMainView()
        setTitleLabel()
        setSegmentedControlContainerView()
        setSegmentedControl()
        setBottomUnderLineView()
        setFormStackView()
        setPasswordFunctionalityStackView()
    }
    
    //MARK: - Set UI Components
    private func setUpMainView() {
        view.backgroundColor = .customBackground
    }
    
    private func setTitleLabel() {
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    private func setSegmentedControlContainerView() {
        view.addSubview(segmentedControlContainerView)
        
        NSLayoutConstraint.activate([
            segmentedControlContainerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            segmentedControlContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentedControlContainerView.widthAnchor.constraint(equalToConstant: 200),
            segmentedControlContainerView.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    private func setSegmentedControl() {
        segmentedControlContainerView.addSubview(segmentedControl)
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: segmentedControlContainerView.topAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: segmentedControlContainerView.leadingAnchor),
            segmentedControl.centerXAnchor.constraint(equalTo: segmentedControlContainerView.centerXAnchor),
            segmentedControl.centerYAnchor.constraint(equalTo: segmentedControlContainerView.centerYAnchor)
        ])
    }
    
    private func setBottomUnderLineView() {
        segmentedControlContainerView.addSubview(bottomUnderlineView)
        
        NSLayoutConstraint.activate([
            bottomUnderlineView.bottomAnchor.constraint(equalTo: segmentedControl.bottomAnchor),
            bottomUnderlineView.heightAnchor.constraint(equalToConstant: 2),
            leadingDistanceConstraint,
            bottomUnderlineView.widthAnchor.constraint(equalTo: segmentedControl.widthAnchor, multiplier: 1 / CGFloat(segmentedControl.numberOfSegments))
        ])
    }
    
    private func setFormStackView() {
        view.addSubview(signInFormStackView)
        
        signInFormStackView.addArrangedSubview(emailTextField)
        signInFormStackView.addArrangedSubview(passwordTextField)
        
        NSLayoutConstraint.activate([
            signInFormStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            signInFormStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            signInFormStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
        ])
    }
    
    private func setPasswordFunctionalityStackView() {
        signInFormStackView.addArrangedSubview(passwordFunctionalityStackView)
        
        passwordFunctionalityStackView.addArrangedSubview(checkBoxButton)
        passwordFunctionalityStackView.addArrangedSubview(rememberPasswordLabel)
        passwordFunctionalityStackView.addArrangedSubview(forgetPasswordLabel)
    }
    
    //MARK: - UI Updates
    private func segmentedValueChanged() {
        changeSegmentedControlLinePosition()
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            logInSegmentChose()
        case 1:
            signUpSegmentChose()
        default:
            break
        }
    }
    
    private func logInSegmentChose() {
        titleLabel.text = LabelValues.Scenes.SignInSignUp.logIn
        signInFormStackView.isHidden = false
    }
    
    private func signUpSegmentChose() {
        titleLabel.text = LabelValues.Scenes.SignInSignUp.signUp
        signInFormStackView.isHidden = true
    }
    
    //MARK: - Animations
    private func changeSegmentedControlLinePosition() {
        let segmentIndex = CGFloat(segmentedControl.selectedSegmentIndex)
        let segmentWidth = segmentedControl.frame.width / CGFloat(segmentedControl.numberOfSegments)
        let leadingDistance = segmentWidth * segmentIndex
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.leadingDistanceConstraint.constant = leadingDistance
            self?.view.layoutIfNeeded()
        })
    }
}

extension SignUpSignInVC {
    enum Event {
        case login
    }
    
    enum Constants {
        static let segmentTitleFontSize: CGFloat = 18
        static let textFieldPadding: CGFloat = 16
        static let verticalStackViewSpacing: CGFloat = 20
        static let horizontalStackViewSpacing: CGFloat = 4
        static let checkBoxCornerRadius: CGFloat = 4
    }
}
