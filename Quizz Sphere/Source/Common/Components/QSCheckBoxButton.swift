//
//  QSCheckBoxButton.swift
//  Quizz Sphere
//
//  Created by Temur Chitashvili on 28.07.24.
//

import UIKit

final class QSCheckBoxButton: UIButton {
    var didSendEventClosure: ((QSCheckBoxButton.Event) -> Void)?
    
    private lazy var checkedImage: UIImage = {
        let image = UIImage(systemName: AppConstants.Images.SystemNames.checkMark)! as UIImage
        return image
    }()
    
    private var isChecked: Bool = false
    
    init() {
        super.init(frame: .zero)
        setQSCheckBoxButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(withCornerRadius cornerRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius
    }
    
    private func setQSCheckBoxButton() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        layer.masksToBounds = true
        backgroundColor = .clear
        frame = CGRect(x: 0, y: 0, width: 22, height: 22)
        addAction(UIAction(handler: { [weak self] _ in
            self?.changeCheckmark()
            self?.isChecked.toggle()
        }), for: .touchUpInside)
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: 22),
            self.heightAnchor.constraint(equalToConstant: 22)
        ])
        imageView?.tintColor = .plusPoint
    }
    
    private func changeCheckmark() {
         if isChecked {
             setImage(nil, for: .normal)
         } else {
             setImage(checkedImage, for: .normal)
         }
     }
}

extension QSCheckBoxButton {
    enum Event {
        case rememberPassword
    }
}
