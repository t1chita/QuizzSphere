//
//  ResultVC.swift
//  Quizz Sphere
//
//  Created by Temur Chitashvili on 17.08.24.
//

import UIKit
import SpriteKit

final class ResultVC: UIViewController {
    //MARK: - Properties
    let viewModel: ResultViewModel
    
    var didSendEventClosure: ((ResultVC.Event) -> Void)?
    
    //MARK: - UIComponents
    private lazy var trophyImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = .trophy
        return imageView
    }()
    
    private lazy var congratulationsLabel: QSLabel = {
        let label = QSLabel()
        label.configure(with: LabelValues.Scenes.Result.congratulations)
        return label
    }()
    
    private lazy var quizIsCompletedLabel: QSLabel = {
        let label = QSLabel()
        
        let partOne = LabelValues.Scenes.Result.quizIsCompletedTextPartOne
        let points = viewModel.userPoints
        let partTwo = LabelValues.Scenes.Result.quizIsCompletedTextPartTwo
        
        let completeText = partOne + " " + String(points) + " " + partTwo
        
        label.configure(with: completeText,
                        fontType: .regular)
        return label
    }()
    
    private lazy var completedQuizzesQuantityTitle: QSLabel = {
        let label = QSLabel()
        label.configure(with: LabelValues.Scenes.Result.completedTasks)
        return label
    }()
    
    private lazy var completedQuizzesQuantityLabel: QSLabel = {
        let label = QSLabel()
        
        let completedQuizQuantity = viewModel.completedQuizQuantity
        let quizQuantity = viewModel.quizQuantity
        let completeText = String(completedQuizQuantity) + " / " + String(quizQuantity)
        
        label.configure(with: completeText,
                        fontType: .bold,
                        textColor: .plusPoint)
        return label
    }()
    
    private lazy var bottomButtonsStackView: QSHorizontalStackView = {
        let stackView = QSHorizontalStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var shareResultButton: QSButton = {
        let button = QSButton()
        button.configure(with: LabelValues.Scenes.Result.shareResults,
                         fontType: .semiBold,
                         backgroundColor: .clear,
                         cornerRadius: Constants.smallButtonCornerRadius,
                         borderWidth: 2,
                         borderColor: .blueCard)
        return button
    }()
    
    private lazy var takeNextQuizButton: QSButton = {
        let button = QSButton()
        button.configure(with: LabelValues.Scenes.Result.takeNewQuiz,
                         fontType: .semiBold,
                         backgroundColor: .blueCard,
                         cornerRadius: Constants.smallButtonCornerRadius)
        return button
    }()
    
    //MARK: - Initialisation
    init(viewModel: ResultViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
        
    //MARK: - Setup UI
    private func setupUI() {
        setMainView()
        setTrophyImage()
        createLayer()
        setCongratulationsLabel()
        setQuizIsCompletedLabel()
        setCompletedQuizzesQuantityTitle()
        setCompletedQuizzesQuantityLabel()
        setBottomButtonsStackView()
    }
    
    //MARK: - Set UI Components
    private func setMainView() {
        title = LabelValues.Scenes.Result.quizResult
        view.backgroundColor = .customBackground
        navigationItem.hidesBackButton = true
    }
    
    private func setTrophyImage() {
        view.addSubview(trophyImage)
        
        NSLayoutConstraint.activate([
            trophyImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            trophyImage.widthAnchor.constraint(equalToConstant: 200),
            trophyImage.heightAnchor.constraint(equalToConstant: 200),
            trophyImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    private func setCongratulationsLabel() {
        view.addSubview(congratulationsLabel)
        
        NSLayoutConstraint.activate([
            congratulationsLabel.topAnchor.constraint(equalTo: trophyImage.bottomAnchor, constant: 30),
            congratulationsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            congratulationsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            congratulationsLabel.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    private func setQuizIsCompletedLabel() {
        view.addSubview(quizIsCompletedLabel)
        
        NSLayoutConstraint.activate([
            quizIsCompletedLabel.topAnchor.constraint(equalTo: congratulationsLabel.bottomAnchor, constant: 10),
            quizIsCompletedLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            quizIsCompletedLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            quizIsCompletedLabel.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    private func setCompletedQuizzesQuantityTitle() {
        view.addSubview(completedQuizzesQuantityTitle)
        
        NSLayoutConstraint.activate([
            completedQuizzesQuantityTitle.topAnchor.constraint(equalTo: quizIsCompletedLabel.bottomAnchor, constant: 50),
            completedQuizzesQuantityTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            completedQuizzesQuantityTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            completedQuizzesQuantityTitle.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    private func setCompletedQuizzesQuantityLabel() {
        view.addSubview(completedQuizzesQuantityLabel)
        
        NSLayoutConstraint.activate([
            completedQuizzesQuantityLabel.topAnchor.constraint(equalTo: completedQuizzesQuantityTitle.bottomAnchor, constant: 10),
            completedQuizzesQuantityLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            completedQuizzesQuantityLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            completedQuizzesQuantityLabel.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    private func setBottomButtonsStackView() {
        view.addSubview(bottomButtonsStackView)
        
        bottomButtonsStackView.addArrangedSubview(shareResultButton)
        bottomButtonsStackView.addArrangedSubview(takeNextQuizButton)
        
        takeNextQuizButton.didSendEventClosure = { [weak self] in
            self?.didSendEventClosure?(.goBack)
        }
        
        shareResultButton.didSendEventClosure = { [weak self] in
            self?.didSendEventClosure?(.shareResult)
        }
        
        NSLayoutConstraint.activate([
            bottomButtonsStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            bottomButtonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -48),
            bottomButtonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 48),
            bottomButtonsStackView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    // MARK: - Setup Animation
    private func createLayer() {
        let layer = CAEmitterLayer()
        
        layer.emitterPosition = CGPoint(x: view.center.x,
                                        y: view.center.y)
        
        let colors: [UIColor] = [
            .systemRed,
            .systemGreen,
            .systemBlue,
            .systemOrange,
            .systemPink,
            .systemYellow,
        ]
        
        let cells: [CAEmitterCell] = colors.compactMap { color in
            let cell = CAEmitterCell()
            cell.scale = 0.01
            cell.emissionRange = .pi * 2
            cell.lifetime = 10
            cell.birthRate = 50
            cell.velocity = 400
            cell.color = color.cgColor
            cell.contents = UIImage(resource: .firework).cgImage
            layer.emitterCells = [cell]
            return cell
        }
        
        layer.emitterCells = cells
        
        view.layer.addSublayer(layer)
    }
}

extension ResultVC {
    enum Constants {
        static let smallButtonCornerRadius: CGFloat = 12
    }
    
    enum Event {
        case goBack
        case shareResult
    }
}
