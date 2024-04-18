//
//  LogInPasswordTextField.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 05.02.2024.
//

import UIKit

class LogInPasswordTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension LogInPasswordTextField {
    
    func setupAppearance() {
        
        layer.cornerRadius = 15
        textContentType = .password
        placeholder = TextFieldResources.PlaceholderString.password
        textColor = ColorResources.white
        backgroundColor = ColorResources.customDarkGrey
        autocorrectionType = .no
        isSecureTextEntry = true
        addPasswordVisibilityButton()
        addSystemIconToLeft(systemName: "lock.circle")
    }
}
