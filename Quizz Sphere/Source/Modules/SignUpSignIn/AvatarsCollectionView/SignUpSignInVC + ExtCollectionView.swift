//
//  SignUpSignInVC + ExtCollectionView.swift
//  Quizz Sphere
//
//  Created by Temur Chitashvili on 08.08.24.
//

import UIKit

extension SignUpSignInVC: UICollectionViewDelegate {
    
}

extension SignUpSignInVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        signUpSignInViewModel.avatarsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AvatarsCell.identifier, for: indexPath) as? AvatarsCell else {
            fatalError("Failed To Dequeue AvatarsCell")
        }
        
        cell.configure(withAvatar: signUpSignInViewModel.avatars[indexPath.row])
        return cell
    }
}

extension SignUpSignInVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.frame.size.width / 3 - 1
        let height: CGFloat = collectionView.frame.size.height / 2
        return CGSize(width: width, height: height)
    }
}
