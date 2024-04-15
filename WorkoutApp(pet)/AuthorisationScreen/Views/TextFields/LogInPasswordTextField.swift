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
        setupAppearence()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension LogInPasswordTextField {
    
    func setupAppearence() {
        
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

extension AuthorisationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            view.endEditing(true)
        default:
            break
        }
        return true
    }
}
