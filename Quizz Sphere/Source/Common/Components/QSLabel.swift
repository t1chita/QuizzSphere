//
//  QSLabel.swift
//  Quizz Sphere
//
//  Created by Temur Chitashvili on 26.07.24.
//

import UIKit

final class QSLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setDefaultProperties()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with text: String?,
                          fontType: AppConstants.FontType = .bold,
                          textAlignment: NSTextAlignment = .center,
                          textColor: UIColor = .primaryText) {
        
        switch fontType {
        case .regular:
            self.font = UIFont(name: "EBGaramond-Regular", size: Constants.regularFontSize)
        case .semiBold:
            self.font = UIFont(name: "EBGaramond-SemiBold", size: Constants.semiBoldFontSize)
        case .bold:
            self.font = UIFont(name: "EBGaramond-Bold", size: Constants.boldFontSize)
        }
        
        self.textColor = textColor
        
        self.textAlignment = textAlignment
        
        self.text = text
    }
    
    private func setDefaultProperties() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension QSLabel {
    enum Constants {
        static let boldFontSize: CGFloat = 24
        static let semiBoldFontSize: CGFloat = 18
        static let regularFontSize: CGFloat = 16
    }
}
