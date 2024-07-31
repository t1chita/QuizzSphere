//
//  QSLabel.swift
//  Quizz Sphere
//
//  Created by Temur Chitashvili on 26.07.24.
//

import UIKit

final class QSLabel: UILabel {

    init() {
        super.init(frame: .zero)
        setQSLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with text: String?,
                          fontType: AppConstants.Font.FontType = .bold,
                          textAlignment: NSTextAlignment = .center,
                          textColor: UIColor = .primaryText) {
        
        switch fontType {
        case .regular:
            self.font = AppConstants.Font.EBGaramond.regular
        case .semiBold:
            self.font = AppConstants.Font.EBGaramond.semibold
        case .bold:
            self.font = AppConstants.Font.EBGaramond.bold
        }
        
        self.textColor = textColor
        
        self.textAlignment = textAlignment
        
        self.text = text
        
        self.numberOfLines = 0
    }
    
    private func setQSLabel() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
