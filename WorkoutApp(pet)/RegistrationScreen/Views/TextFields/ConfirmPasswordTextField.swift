//
//  ConfirmPasswordTextField.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 04.02.2024.
//

import UIKit

final class ConfirmPasswordTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupAppearence()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ConfirmPasswordTextField {
    
    func setupAppearence() {
        
        layer.cornerRadius = 15
        layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
        placeholder = Resources.TextField.Strings.confirmPassword
        textColor = Resources.Colors.white
        backgroundColor = Resources.Colors.customDarkGrey
    }
}
