//
//  UIViewExtension.swift
//  Exercises
//
//  Created by Igor Tudoran on 8/23/19.
//  Copyright © 2019 DIGIS IOS. All rights reserved.
//

import UIKit

extension UIView {
    
    func roundCorners(_ value: CGFloat = 8.0) {
        self.layer.cornerRadius = value
    }
    
    func circleIt() {
        self.layer.cornerRadius = self.frame.width/2
        self.layer.masksToBounds = true
    }
    
    func addShadow(_ color: UIColor = UIColor.black) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 8.0
        self.layer.shadowOpacity = 0.3
        self.layer.shadowPath =
            UIBezierPath(roundedRect: self.bounds,
                         cornerRadius: self.layer.cornerRadius).cgPath
    }
    
    func addBottomShadow(_ color: UIColor = UIColor.black) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        self.layer.shadowRadius = 8.0
        self.layer.shadowOpacity = 0.3
        self.layer.shadowPath =
            UIBezierPath(roundedRect: self.bounds,
                         cornerRadius: self.layer.cornerRadius).cgPath
    }
    
    func addBorder(_ width: CGFloat, color: UIColor = .white) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
    
    // MARK: -
    
    func show() {
        if self.alpha == 1.0 {
            return
        }
        UIView.animate(withDuration: kDefaultAnimationDuration) {
            self.alpha = 1.0
        }
    }
    
    func hide() {
        if self.alpha == 0.0 {
            return
        }
        UIView.animate(withDuration: kDefaultAnimationDuration) {
            self.alpha = 0.0
        }
    }
    
    func showOn(_ view: UIView) {
        self.alpha = 0
        view.addSubview(self)
        view.bringSubviewToFront(self)
        self.center = view.center
        UIView.animate(withDuration: kDefaultAnimationDuration) {
            self.alpha = 1.0
        }
    }
    
    func close() {
        UIView.animate(withDuration: kDefaultAnimationDuration, animations: {
            self.alpha = 0
        }, completion: { (_) in
            self.removeFromSuperview()
        })
    }
    
    // MARK: -
    
    func snapshot() -> UIImage? {
        UIGraphicsBeginImageContext(self.frame.size)
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func allowHidingKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.addGestureRecognizer(tap)
    }
}
