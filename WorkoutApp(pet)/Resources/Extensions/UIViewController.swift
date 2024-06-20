//
//  UIViewController.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 15.06.2024.
//

import UIKit

extension UIViewController {
    
    func setupHideKeyboardOnTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}

