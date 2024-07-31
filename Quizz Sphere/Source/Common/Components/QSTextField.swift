//
//  QSTextField.swift
//  Quizz Sphere
//
//  Created by Temur Chitashvili on 25.07.24.
//

import UIKit

enum ValidationType {
    case email
    case nickname
    case password
}

final class QSTextField: UITextField {
    private lazy var bottomLine: CALayer = {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0,
                                  y: self.frame.height - 2,
                                  width: self.frame.width,
                                  height: 2)
        bottomLine.backgroundColor = UIColor.white.cgColor
        return bottomLine
    }()
    
    init() {
        super.init(frame: .zero)
        setupTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        borderStyle = .none
        layer.addSublayer(bottomLine)
    }
    
    public func configure(withPadding padding: PaddingSpace,
                          iconName: String,
                          placeHolder: String,
                          isSecured: Bool = false) {
        
        let icon = UIImageView(image: UIImage(systemName: iconName))
        icon.contentMode = .scaleAspectFit
        icon.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        icon.tintColor = .white
        
        leftViewMode = .always
        layer.masksToBounds = true
        
        switch padding {
        case .left(let spacing):
            let leftPaddingView = UIView(frame: CGRect(x: 0,
                                                       y: 0,
                                                       width: spacing + 16,
                                                       height: frame.height + 26))
            leftPaddingView.addSubview(icon)
            leftView = leftPaddingView
            leftViewMode = .always
        case .right(let spacing):
            let rightPaddingView = UIView(frame: CGRect(x: 0,
                                                        y: 0,
                                                        width: spacing,
                                                        height: frame.height))
            rightView = rightPaddingView
            leftViewMode = .always
        case .equalSpacing(let spacing):
            let equalPaddingView = UIView(frame: CGRect(x: 0,
                                                        y: 0,
                                                        width: spacing,
                                                        height: frame.height))
            leftView = equalPaddingView
            leftViewMode = .always
            rightView = equalPaddingView
            rightViewMode = .always
        }
        
        self.placeholder = placeHolder
        self.isSecureTextEntry = isSecured
    }
    
    private func setupTextField() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        font = AppConstants.Font.EBGaramond.regular
        textColor = .primaryText
        heightAnchor.constraint(equalToConstant: 26).isActive = true
    }
}

extension QSTextField {
    enum PaddingSpace {
        case left(CGFloat)
        case right(CGFloat)
        case equalSpacing(CGFloat)
    }
}
