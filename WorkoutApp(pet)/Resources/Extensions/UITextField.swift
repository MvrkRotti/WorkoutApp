//
//  UITextField.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 15.04.2024.
//

import UIKit

//MARK: - Show/Hide button

class PasswordVisibilityButton: UIButton {
    private let showPass = UIImage(systemName: "eye")
    private let hidePass = UIImage(systemName: "eye.slash")
    
    var isPasswordVisible = false {
        didSet {
            updateButtonImage()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        
        updateButtonImage()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func updateButtonImage() {
        let image = isPasswordVisible ? hidePass : showPass
        setImage(image, for: .normal)
    }
    
    @objc private func togglePasswordVisibility() {
        isPasswordVisible.toggle()
    }
}

//MARK: - Setup right mode for button
extension UITextField {
    func addPasswordVisibilityButton() {
        let button = PasswordVisibilityButton(type: .custom)
        button.tintColor = ColorResources.customCoral
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 30)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        button.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        rightView = button
        rightViewMode = .always
    }
    
    @objc private func togglePasswordVisibility() {
        isSecureTextEntry.toggle()
        if let button = rightView as? PasswordVisibilityButton {
            button.isPasswordVisible = !isSecureTextEntry
        }
    }
}



extension UITextField {
    func addSystemIconToLeft(systemName: String) {
        let iconView = UIImageView(frame: CGRect(x: 8, y: 0, width: 25, height: 25))
        iconView.image = UIImage(systemName: systemName)
        iconView.tintColor = ColorResources.customCoral
        iconView.contentMode = .scaleAspectFit
        
        let iconContainerView: UIView = {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 33, height: 25))
            view.addSubview(iconView)
            return view
        }()
        
        leftView = iconContainerView
        leftViewMode = .always
    }
}
