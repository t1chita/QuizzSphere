//
//  QuizCell.swift
//  Quizz Sphere
//
//  Created by Temur Chitashvili on 05.08.24.
//

import UIKit

final class QuizCell: UITableViewCell {
    //MARK: - Properties
    static let identifier: String = "QuizCell"
    var quizId: String = ""
    
    //MARK: - UIComponents
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.layer.masksToBounds = true
        view.layer.cornerRadius = Constants.containerViewCornerRadius
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    private lazy var contentHorizontalStackView: QSHorizontalStackView = {
        let stackView = QSHorizontalStackView()
        stackView.spacing = Constants.horizontalStackViewSpacing
        return stackView
    }()
    
    private lazy var quizImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Constants.imageViewCornerRadius
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor .constraint(equalToConstant: 60).isActive = true
        return imageView
    }()
    
    private lazy var quizInfoVerticalStackView: QSVerticalStackView = {
        let stackView = QSVerticalStackView()
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private lazy var quizTitleLabel: QSLabel = {
        let label = QSLabel()
        label.configure(with: LabelValues.Scenes.Home.noName,
                        fontType: .semiBold,
                        textAlignment: .left,
                        textColor: .primaryText)
        return label
    }()
    
    private lazy var quizCategoryLabel: QSLabel = {
        let label = QSLabel()
        label.configure(with: LabelValues.Scenes.Home.noCategory,
                        fontType: .regular,
                        textAlignment: .left,
                        textColor: .secondaryText)
        return label
    }()
    
    private lazy var quizQuantityLabel: QSLabel = {
        let label = QSLabel()
        label.configure(with: LabelValues.Scenes.Home.noQuantity,
                        fontType: .regular,
                        textAlignment: .left,
                        textColor: .secondaryText)
        return label
    }()
    
    private lazy var chevronSymbol: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = .pinkCard
        imageView.contentMode = .scaleAspectFit
        imageView.widthAnchor .constraint(equalToConstant: 20).isActive = true
        return imageView
    }()
    
    //MARK: - Initialisation
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configure
    func configure(withQuiz quiz: Quiz) {
        guard let quizImageUrl = URL(string: quiz.imageUrl) else { return }
        quizTitleLabel.text = quiz.name
        quizCategoryLabel.text = quiz.category
        quizQuantityLabel.text = String(quiz.quantity) + " Quizzes"
        quizId = quiz.id
        quizImageView.loadImage(from: quizImageUrl)
    }
    
    //MARK: - Setup UI
    private func setupUI() {
        setContainerView()
        setContentHorizontalStackView()
        setArrangedSubviewsInContentInHorizontalStackView()
    }
    //MARK: - Set UI Components
    private func setContainerView() {
        addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ])
    }
    
    private func setContentHorizontalStackView() {
        containerView.addSubview(contentHorizontalStackView)
        
        NSLayoutConstraint.activate([
            contentHorizontalStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            contentHorizontalStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            contentHorizontalStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            contentHorizontalStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
        ])
    }
    
    private func setArrangedSubviewsInContentInHorizontalStackView() {
        contentHorizontalStackView.addArrangedSubview(quizImageView)
        setQuizInfoVerticalStackView()
        contentHorizontalStackView.addArrangedSubview(quizInfoVerticalStackView)
        contentHorizontalStackView.addArrangedSubview(chevronSymbol)
    }
    
    private func setQuizInfoVerticalStackView() {
        quizInfoVerticalStackView.addArrangedSubview(quizTitleLabel)
        quizInfoVerticalStackView.addArrangedSubview(quizCategoryLabel)
        quizInfoVerticalStackView.addArrangedSubview(quizQuantityLabel)
    }
}

extension QuizCell {
    enum Constants {
        static let containerViewCornerRadius: CGFloat = 20
        static let imageViewCornerRadius: CGFloat = 6
        static let horizontalStackViewSpacing: CGFloat = 10
    }
}
