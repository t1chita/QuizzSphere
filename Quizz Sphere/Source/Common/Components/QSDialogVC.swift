//
//  QSDialogVC.swift
//  Quizz Sphere
//
//  Created by Temur Chitashvili on 13.08.24.
//

import UIKit

final class QSDialogVC: UIViewController {
    //MARK: - Properties
    var didSendEventClosure: ((QSDialogVC.Event) -> Void)?
    
    //MARK: - UIComponents
    private lazy var backView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black.withAlphaComponent(0.6)
        view.alpha = 0
        return view
    }()
    
    private lazy var contentView: QSCard = {
        let card = QSCard()
        card.configure(withCornerRadius: Constants.cardSmallCornerRadius,
                       backgroundColor: .pinkCard)
        card.alpha = 0
        return card
    }()
    
    private lazy var popupTitle: QSLabel = {
        let label = QSLabel()
        return label
    }()
    
    private lazy var popupMessage: QSLabel = {
       let label = QSLabel()
        return label
    }()
    
    private lazy var bottomButton: QSButton = {
       let button = QSButton()
        return button
    }()
    
    //MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - Setup UI
    private func setupUI() {
        setBackView()
        setContentView()
        setCongratulationsLabel()
        setPopupMessage()
        setNextButton()
    }
    
    //MARK: - Set UI Components
    private func setMainView() {
        view.backgroundColor = .clear
    }
    
    private func setBackView() {
        view.addSubview(backView)
        
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: view.topAnchor),
            backView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func setContentView() {
        backView.addSubview(contentView)
    
        NSLayoutConstraint.activate([
            contentView.centerXAnchor.constraint(equalTo: backView.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: backView.centerYAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 150),
            contentView.widthAnchor.constraint(equalToConstant: 250),
        ])
    }
    
    private func setCongratulationsLabel() {
        contentView.addSubview(popupTitle)
        
        NSLayoutConstraint.activate([
            popupTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            popupTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            popupTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            popupTitle.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    private func setPopupMessage() {
        contentView.addSubview(popupMessage)
        
        NSLayoutConstraint.activate([
            popupMessage.topAnchor.constraint(equalTo: popupTitle.bottomAnchor, constant: 10),
            popupMessage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            popupMessage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            popupMessage.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    private func setNextButton() {
        contentView.addSubview(bottomButton)
        
        bottomButton.didSendEventClosure = { [weak self] in
            self?.didSendEventClosure?(.hide)
            self?.hide()
        }
        
        NSLayoutConstraint.activate([
            bottomButton.topAnchor.constraint(equalTo: popupMessage.bottomAnchor, constant: 10),
            bottomButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            bottomButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            bottomButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
        
    }
    
    func appear(onSender vc: UIViewController,
                withTitle title: String,
                message: String,
                buttonTitle: String) {
        
        self.popupTitle.configure(with: title)
        self.popupMessage.configure(with: message,
                                    fontType: .regular,
                                    textAlignment: .center,
                                    textColor: .primaryText)
        
         bottomButton.configure(with: buttonTitle,
                          fontType: .semiBold,
                          backgroundColor: .blueCard,
                          cornerRadius: Constants.cardSmallCornerRadius)
    
        self.modalPresentationStyle = .overFullScreen
        vc.present(self, animated: false) { [weak self] in
            self?.show()
        }
    }
    
    private func show() {
        UIView.animate(withDuration: 0.5,
                       delay: 0) { [weak self] in
            
            self?.backView.alpha = 1
            self?.contentView.alpha = 1
        }
    }
    
    private func hide() {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: .curveEaseInOut) { [weak self] in
            self?.backView.alpha = 0
            self?.contentView.alpha = 0
            
        } completion: { [weak self] _ in
            self?.dismiss(animated: false)
            self?.removeFromParent()
        }
    }
}

extension QSDialogVC {
    enum Constants {
        static let cardSmallCornerRadius: CGFloat = 12
    }
    
    enum Event {
        case hide
    }
}
