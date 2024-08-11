//
//  UIView.swift
//  Quizz Sphere
//
//  Created by Temur Chitashvili on 06.08.24.
//

import UIKit

extension UIView {
    
    /**
     Rounds the given set of corners to the specified radius
     
     - parameter corners: Corners to round
     - parameter radius:  Radius to round to
     */
    func round(corners: UIRectCorner, radius: CGFloat) {
        _ = _round(corners: corners, radius: radius)
    }
    
    /**
     Rounds the given set of corners to the specified radius with a border
     
     - parameter corners:     Corners to round
     - parameter radius:      Radius to round to
     - parameter borderColor: The border color
     - parameter borderWidth: The border width
     */
    func round(corners: UIRectCorner, radius: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
        let mask = _round(corners: corners, radius: radius)
        addBorder(mask: mask, borderColor: borderColor, borderWidth: borderWidth)
    }
    
    /**
     Fully rounds an autolayout view (e.g. one with no known frame) with the given diameter and border
     
     - parameter diameter:    The view's diameter
     - parameter borderColor: The border color
     - parameter borderWidth: The border width
     */
    func fullyRound(diameter: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
        layer.masksToBounds = true
        layer.cornerRadius = diameter / 2
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor;
    }
    
}

private extension UIView {
    
    @discardableResult func _round(corners: UIRectCorner, radius: CGFloat) -> CAShapeLayer {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
        return mask
    }
    
    func addBorder(mask: CAShapeLayer, borderColor: UIColor, borderWidth: CGFloat) {
        let borderLayer = CAShapeLayer()
        borderLayer.path = mask.path
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = borderColor.cgColor
        borderLayer.lineWidth = borderWidth
        borderLayer.frame = bounds
        layer.addSublayer(borderLayer)
    }
}

//extension UIView {
//    func animShow(height: CGFloat) {
//        self.isHidden = false
//        
//        if let existingHeightConstraint = self.constraints.first(where: { $0.firstAttribute == .height }) {
//            existingHeightConstraint.isActive = false
//        }
//        
//        // Activate the new height constraint
//        let newHeightConstraint = self.heightAnchor.constraint(equalToConstant: height)
//        newHeightConstraint.isActive = true
//        
//        
//        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseIn], animations: {
//            self.superview?.layoutIfNeeded()
//        }, completion: nil)
//    }
//    
//    
//    func animHide() {
//        // Find and deactivate the existing height constraint, if any
//        if let existingHeightConstraint = self.constraints.first(where: { $0.firstAttribute == .height }) {
//            existingHeightConstraint.isActive = false
//        }
//        
//        // Activate the new height constraint
//        let newHeightConstraint = self.heightAnchor.constraint(equalToConstant: 0)
//        newHeightConstraint.isActive = true
//        
//        // Animate the change
//        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseIn], animations: {
//            self.superview?.layoutIfNeeded()
//        }, completion: { completed in
//            // Only hide the view after the animation has finished
//            if completed {
//                self.isHidden = true
//            }
//        })
//    }
//}
//
//
