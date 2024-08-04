//
//  QSHorizontalStackView.swift
//  Quizz Sphere
//
//  Created by Temur Chitashvili on 01.08.24.
//

import UIKit

final class QSHorizontalStackView: UIStackView {
    init() {
        super.init(frame: .zero)
        setQSVerticalStackView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setQSVerticalStackView() {
        translatesAutoresizingMaskIntoConstraints = false
        axis = .horizontal
        distribution = .fillProportionally
    }
}

