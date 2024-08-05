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
                          cornerRadius: CGFloat) {
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
        
        self.contentHorizontalAlignment = contentAlignment
        
        self.backgroundColor = backgroundColor
        
        self.layer.cornerRadius = cornerRadius
    }
    
    private func setQSButton() {
        translatesAutoresizingMaskIntoConstraints = false
        addAction(UIAction(handler: { [weak self] _ in
            self?.didSendEventClosure?()
        }), for: .touchUpInside)
    }
}
