//
//  QSButton.swift
//  Quizz Sphere
//
//  Created by Temur Chitashvili on 28.07.24.
//

import UIKit

final class QSButton: UIButton {
    var didSendEventClosure: (() -> Void)?
    
    init() {
        super.init(frame: .zero)
        setQSButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with text: String?,
                          fontType: AppConstants.Font.FontType = .bold,
                          contentAlignment: ContentHorizontalAlignment = .center,
                          textColor: UIColor = .primaryText,
                          backgroundColor: UIColor = .blueCard,
                          cornerRadius: CGFloat,
                          borderWidth: CGFloat = 0,
                          borderColor: UIColor = .clear) {
        
        setTitle(text, for: .normal)
        setTitleColor(textColor, for: .normal)
        
        switch fontType {
        case .regular:
            titleLabel?.font = AppConstants.Font.EBGaramond.regular
        case .semiBold:
            titleLabel?.font = AppConstants.Font.EBGaramond.semibold
        case .bold:
            titleLabel?.font = AppConstants.Font.EBGaramond.bold
        }
        
        self.titleLabel?.numberOfLines = 0
        
        self.contentHorizontalAlignment = contentAlignment
        
        self.backgroundColor = backgroundColor
        
        self.layer.cornerRadius = cornerRadius
        
        if borderWidth != 0 {
            self.layer.masksToBounds = true
            self.layer.borderColor = borderColor.cgColor
            self.layer.borderWidth = borderWidth
        }
    }
    
    private func setQSButton() {
        translatesAutoresizingMaskIntoConstraints = false
        addAction(UIAction(handler: { [weak self] _ in
            self?.didSendEventClosure?()
        }), for: .touchUpInside)
    }
}
