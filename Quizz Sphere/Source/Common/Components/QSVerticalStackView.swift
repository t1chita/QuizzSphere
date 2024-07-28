//
//  QSVerticalStackView.swift
//  Quizz Sphere
//
//  Created by Temur Chitashvili on 28.07.24.
//

import UIKit

final class QSVerticalStackView: UIStackView {
    init() {
        super.init(frame: .zero)
    setQSVerticalStackView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setQSVerticalStackView() {
        translatesAutoresizingMaskIntoConstraints = false
        axis = .vertical
        alignment = .fill
        distribution = .fillProportionally
    }
}
