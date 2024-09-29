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
    
    func navBarSettingsWith(title: String) {
        navigationItem.title = title
        navigationController?.navigationBar.backgroundColor = ColorResources.white
        
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [
            .font: FontResources.boldSystemFont20,
            .foregroundColor: ColorResources.black
        ]
        
        navigationController?.navigationBar.standardAppearance = appearance
    }
    
    func setGradientBackground() {
        let topColor = ColorResources.gradientTopColor.cgColor
        
        let middleColor = ColorResources.gradientMiddleColor.cgColor
        
        let bottomColor = ColorResources.gradientBottomColor.cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor, middleColor, bottomColor]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        gradientLayer.frame = self.view.bounds
        
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    
    func setupViews(_ views: UIView...) {
        views.forEach { UIElement in
            view.addSubview(UIElement)
            UIElement.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}

