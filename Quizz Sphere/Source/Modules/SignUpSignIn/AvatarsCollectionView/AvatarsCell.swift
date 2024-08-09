//
//  AvatarsCell.swift
//  Quizz Sphere
//
//  Created by Temur Chitashvili on 08.08.24.
//

import UIKit

final class AvatarsCell: UICollectionViewCell {
    static let identifier: String = "AvatarsCell"
    
    private lazy var avatarImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(withAvatar avatar: Avatar) {
        guard let avatarImageUrl = URL(string: avatar.imageUrl) else { return }
        avatarImage.loadImage(from: avatarImageUrl)
    }
    
    private func setup() {
        setAvatarImage()
        cellSetup()
    }
    
    private func cellSetup() {
    }
    
    private func setAvatarImage() {
        addSubview(avatarImage)
        
        NSLayoutConstraint.activate([
            avatarImage.topAnchor.constraint(equalTo: topAnchor),
            avatarImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            avatarImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            avatarImage.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
