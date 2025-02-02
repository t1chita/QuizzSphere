//
//  QSCard.swift
//  Quizz Sphere
//
//  Created by Temur Chitashvili on 04.08.24.
//

import UIKit

final class QSCard: UIView {
    
    init() {
        super.init(frame: .zero)
        setQSCard()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(withCornerRadius cornerRadius: CGFloat = 0,
                          backgroundColor color: UIColor) {
        self.backgroundColor = color
        self.layer.cornerRadius = cornerRadius
    }

    private func setQSCard() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.masksToBounds = false
    }
}
