//
//  UIViewController.swift
//  Quizz Sphere
//
//  Created by Temur Chitashvili on 01.08.24.
//

import UIKit

extension UIViewController {
    //MARK: - Gestures
    func addHideKeyboardTapGestureRecogniser() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}
