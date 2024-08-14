//
//  AnswersCell.swift
//  Quizz Sphere
//
//  Created by Temur Chitashvili on 13.08.24.
//

import UIKit

final class AnswersCell: UICollectionViewCell {
    //MARK: - Properties
    static let identifier: String = "AnswersCell"
    //MARK: - UIComponents
    private lazy var customBackgroundView: QSCard = {
        let view = QSCard()
        view.configure(withCornerRadius: Constants.cardSmallCornerRadius,
                       backgroundColor: .blueCard)
        return view
    }()
    
    private lazy var answerLabel: QSLabel = {
       let label = QSLabel()
        label.configure(with: LabelValues.Scenes.Questions.noAnswer,
                        fontType: .regular)
        return label
    }()
    //MARK: - Initialisation
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configure
    func configure(withAnswer answer: Answer) {
        answerLabel.text = answer.description
    }
    
    //MARK: - Setup UI
    private func setupUI() {
        setCustomBackgroundView()
        setAnswerLabel()
    }
    //MARK: - Set UI Components
    
    private func setCustomBackgroundView() {
        addSubview(customBackgroundView)
        
        NSLayoutConstraint.activate([
            customBackgroundView.topAnchor.constraint(equalTo: topAnchor),
            customBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            customBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            customBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    private func setAnswerLabel() {
        customBackgroundView.addSubview(answerLabel)
        
        NSLayoutConstraint.activate([
            answerLabel.centerXAnchor.constraint(equalTo: customBackgroundView.centerXAnchor),
            answerLabel.centerYAnchor.constraint(equalTo: customBackgroundView.centerYAnchor),
            answerLabel.widthAnchor.constraint(equalTo: customBackgroundView.widthAnchor, constant: -6)
        ])
    }
}


extension AnswersCell {
    enum Constants {
        static let cardSmallCornerRadius: CGFloat = 10
    }
}
