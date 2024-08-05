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
            NSAttributedString.Key.foregroundColor: UIColor.blueCard,
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
        underlineView.backgroundColor = .blueCard
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        return underlineView
    }()
    
    private lazy var leadingDistanceConstraint: NSLayoutConstraint = {
        return bottomUnderlineView.leftAnchor.constraint(equalTo: segmentedControl.leftAnchor)
    }()
    
    private lazy var signInFormStackView: QSVerticalStackView = {
        let stackView = QSVerticalStackView()
        stackView.spacing = Constants.verticalStackViewSpacing
        return stackView
    }()
    
    private lazy var signInEmailTextField: QSTextField = {
        let emailTextField = QSTextField()
        emailTextField.configure(withPadding: .left(Constants.textFieldPadding),
                                 iconName: AppConstants.Images.SystemNames.emailIcon,
                                 placeHolder: LabelValues.Scenes.SignInSignUp.emailPlaceHolder)
        return emailTextField
    }()
    
    private lazy var signInPasswordTextField: QSTextField = {
        let passwordTextField = QSTextField()
        passwordTextField.configure(withPadding: .left(Constants.textFieldPadding),
                                    iconName: AppConstants.Images.SystemNames.passwordIcon,
                                    placeHolder: LabelValues.Scenes.SignInSignUp.passwordPlaceHolder,
                                    isSecured: true)
        return passwordTextField
    }()
    
    private lazy var signInFormValidateLabel: QSLabel = {
        let formValidateLabel = QSLabel()
        formValidateLabel.configure(with: LabelValues.Scenes.SignInSignUp.incorrectFormInfo,
                                    fontType: .regular,
                                    textAlignment: .left,
                                    textColor: .minusPoint)
        return formValidateLabel
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
        button.configure(withCornerRadius: Constants.buttonCornerRadius)
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
    
    private lazy var signInButton: QSButton = {
        let button = QSButton()
        button.configure(with: LabelValues.Scenes.SignInSignUp.logIn,
                         fontType: .regular,
                         cornerRadius: Constants.buttonCornerRadius)
        return button
    }()
    
    private lazy var signUpFormStackView: QSVerticalStackView = {
        let stackView = QSVerticalStackView()
        stackView.spacing = Constants.verticalStackViewSpacing
        stackView.isHidden = true
        return stackView
    }()
    
    private lazy var signUpEmailTextField: QSTextField = {
        let emailTextField = QSTextField()
        emailTextField.configure(withPadding: .left(Constants.textFieldPadding),
                                 iconName: AppConstants.Images.SystemNames.emailIcon,
                                 placeHolder: LabelValues.Scenes.SignInSignUp.emailPlaceHolder)
        return emailTextField
    }()
    
    
    private lazy var signUpEmailValidateLabel: QSLabel = {
        let signUpEmailValidateLabel = QSLabel()
        signUpEmailValidateLabel.configure(with: signUpSignInViewModel.isInputValid(forType: .email),
                                           fontType: .regular,
                                           textAlignment: .left,
                                           textColor: .minusPoint)
        return signUpEmailValidateLabel
    }()
    
    private lazy var signUpNickNameTextField: QSTextField = {
        let nickNameTextField = QSTextField()
        nickNameTextField.configure(withPadding: .left(Constants.textFieldPadding),
                                    iconName: AppConstants.Images.SystemNames.person,
                                    placeHolder: LabelValues.Scenes.SignInSignUp.nickNamePlaceHolder)
        return nickNameTextField
    }()
    
    private lazy var signUpNickNameValidateLabel: QSLabel = {
        let signUpNickNameValidateLabel = QSLabel()
        signUpNickNameValidateLabel.configure(with: signUpSignInViewModel.isInputValid(forType: .nickname),
                                              fontType: .regular,
                                              textAlignment: .left,
                                              textColor: .minusPoint)
        return signUpNickNameValidateLabel
    }()
    
    private lazy var signUpPasswordTextField: QSTextField = {
        let passwordTextField = QSTextField()
        passwordTextField.configure(withPadding: .left(Constants.textFieldPadding),
                                    iconName: AppConstants.Images.SystemNames.passwordIcon,
                                    placeHolder: LabelValues.Scenes.SignInSignUp.passwordPlaceHolder,
                                    isSecured: true)
        return passwordTextField
    }()
    
    private lazy var signUpPasswordValidateLabel: QSLabel = {
        let signUpPasswordValidateLabel = QSLabel()
        signUpPasswordValidateLabel.configure(with: signUpSignInViewModel.isInputValid(forType: .password),
                                              fontType: .regular,
                                              textAlignment: .left,
                                              textColor: .minusPoint)
        return signUpPasswordValidateLabel
    }()
    
    private lazy var signUpButton: QSButton = {
        let button = QSButton()
        button.configure(with: LabelValues.Scenes.SignInSignUp.signUp,
                         fontType: .regular,
                         cornerRadius: Constants.buttonCornerRadius)
        return button
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
        addHideKeyboardTapGestureRecogniser()
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
        setSignUpStackView()
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
        
        signInFormStackView.addArrangedSubview(signInEmailTextField)
        signInFormStackView.addArrangedSubview(signInPasswordTextField)
        signInFormStackView.addArrangedSubview(signInFormValidateLabel)
        signInFormStackView.addArrangedSubview(signInButton)
        
        signInButton.didSendEventClosure = {[weak self] in
            self?.handleLoginButtonTapped()
        }
        
        NSLayoutConstraint.activate([
            signInFormStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            signInFormStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            signInFormStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
        ])
        
        signInFormValidateLabel.isHidden = true
    }
    
    private func setPasswordFunctionalityStackView() {
        signInFormStackView.addArrangedSubview(passwordFunctionalityStackView)
        
        passwordFunctionalityStackView.addArrangedSubview(checkBoxButton)
        passwordFunctionalityStackView.addArrangedSubview(rememberPasswordLabel)
        passwordFunctionalityStackView.addArrangedSubview(forgetPasswordLabel)
    }
    
    private func setSignUpStackView() {
        view.addSubview(signUpFormStackView)
        
        signUpFormStackView.addArrangedSubview(signUpEmailTextField)
        signUpFormStackView.addArrangedSubview(signUpEmailValidateLabel)
        signUpFormStackView.addArrangedSubview(signUpNickNameTextField)
        signUpFormStackView.addArrangedSubview(signUpNickNameValidateLabel)
        signUpFormStackView.addArrangedSubview(signUpPasswordTextField)
        signUpFormStackView.addArrangedSubview(signUpPasswordValidateLabel)
        signUpFormStackView.addArrangedSubview(signUpButton)
        
        signUpEmailValidateLabel.isHidden = true
        signUpNickNameValidateLabel.isHidden = true
        signUpPasswordValidateLabel.isHidden = true

        signUpEmailTextField.addAction(UIAction(handler: { [weak self] _ in
            self?.signUpSignInViewModel.signupEmail = self?.signUpEmailTextField.text ?? ""
            self?.validateEmail()
        }), for: .editingDidEnd)
        
        signUpNickNameTextField.addAction(UIAction(handler: { [weak self] _ in
            self?.signUpSignInViewModel.signUpNickname = self?.signUpNickNameTextField.text ?? ""
            self?.validateNickname()
        }), for: .editingDidEnd)
        
        signUpPasswordTextField.addAction(UIAction(handler: { [weak self] _ in
            self?.signUpSignInViewModel.signUpPassword = self?.signUpPasswordTextField.text ?? ""
            self?.validatePassword()
        }), for: .editingDidEnd)
        
        signUpButton.didSendEventClosure = {[weak self] in
            self?.handleSignUpButtonTapped()
        }
        
        NSLayoutConstraint.activate([
            signUpFormStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            signUpFormStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            signUpFormStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
        ])
    }
    
    private func validateEmail() {
        if signUpSignInViewModel.isEmailValid {
            signUpEmailValidateLabel.isHidden = true
        } else {
            signUpEmailValidateLabel.isHidden = false
        }
    }
    
    private func validateNickname() {
        if signUpSignInViewModel.isNicknameValid {
            signUpNickNameValidateLabel.isHidden = true
        } else {
            signUpNickNameValidateLabel.isHidden = false
        }
    }
    
    private func validatePassword() {
        if signUpSignInViewModel.isPasswordValid {
            signUpPasswordValidateLabel.isHidden = true
        } else {
            signUpPasswordValidateLabel.isHidden = false
        }
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
        signUpFormStackView.isHidden = true
    }
    
    private func signUpSegmentChose() {
        titleLabel.text = LabelValues.Scenes.SignInSignUp.signUp
        signInFormStackView.isHidden = true
        signUpFormStackView.isHidden = false
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

//MARK: - Actions
extension SignUpSignInVC {
    private func handleSignUpButtonTapped() {
        setViewModelSignUpProperties()
        signUpSignInViewModel.createUser { [weak self] success in
            DispatchQueue.main.async { [weak self] in
                switch success {
                case true:
                    self?.didSendEventClosure?(.signup)
                    print("DEBUG: User Saved Successfully")
                case false:
                    print("DEBUG: Can't Save User")
                }
            }
        }
    }
    
    private func handleLoginButtonTapped() {
        setViewModelSignUInProperties()
        signUpSignInViewModel.signIn { [weak self] success in
            DispatchQueue.main.async { [weak self] in
                switch success {
                case true:
                    self?.didSendEventClosure?(.login)
                    self?.signInFormValidateLabel.isHidden = true
                    print("DEBUG: User Sign In Successfully")
                case false:
                    self?.signInFormValidateLabel.isHidden = false
                    print("DEBUG: User Sign In UnSuccessfully")
                }
            }
        }
    }
    
    private func setViewModelSignUpProperties() {
        signUpSignInViewModel.signupEmail = signUpEmailTextField.text ?? ""
        signUpSignInViewModel.signUpNickname = signUpNickNameTextField.text ?? ""
        signUpSignInViewModel.signUpPassword = signUpPasswordTextField.text ?? ""
        
        print("DEBUG: Set view model properties - Email: \(signUpSignInViewModel.signupEmail), Nickname: \(signUpSignInViewModel.signUpNickname), Password: \(signUpSignInViewModel.signUpPassword)")
    }  
    
    private func setViewModelSignUInProperties() {
        signUpSignInViewModel.signInEmail = signInEmailTextField.text ?? ""
        signUpSignInViewModel.signInPassword = signInPasswordTextField.text ?? ""
        
        print("DEBUG: Set view model properties - Email: \(signUpSignInViewModel.signInEmail), Password: \(signUpSignInViewModel.signInPassword)")
    }
}



extension SignUpSignInVC {
    enum Event {
        case login
        case signup
    }
    
    enum Constants {
        static let segmentTitleFontSize: CGFloat = 18
        static let textFieldPadding: CGFloat = 16
        static let verticalStackViewSpacing: CGFloat = 20
        static let horizontalStackViewSpacing: CGFloat = 4
        static let buttonCornerRadius: CGFloat = 4
    }
}
