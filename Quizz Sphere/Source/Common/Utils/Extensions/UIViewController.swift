//
//  UIViewController.swift
//  Quizz Sphere
//
//  Created by Temur Chitashvili on 01.08.24.
//

import UIKit

extension UIViewController: UITextFieldDelegate {
    //MARK: - KeyBoard Return
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         self.view.endEditing(true)
         return false
     }
}
