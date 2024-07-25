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
        label.configure(with: "Login")
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
        segmentedControl.insertSegment(withTitle: "Log In", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "Sign Up", at: 1, animated: false)
        
        //Set Segments Titles
        segmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel,
            NSAttributedString.Key.font:  UIFont(name: "EBGaramond-Bold", size: Constants.segmentTitleFontSize) as Any], for: .normal)
        
        segmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.customCardColors,
            NSAttributedString.Key.font: UIFont(name: "EBGaramond-Bold", size: Constants.segmentTitleFontSize) as Any], for: .selected)
        
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
        titleLabel.text = "Log In"
    }
    
    private func signUpSegmentChose() {
        titleLabel.text = "Sign Up"
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
    }
}
