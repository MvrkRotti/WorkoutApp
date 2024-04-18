//
//  CustomTextField.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 26.03.2024.
//

import UIKit

final class CustomTextField: UITextField {
    
    enum CustomTextFieldType {
        case name
        case lastName
        case email
        case password
        case confirmPassword
    }
    
    private let registrationFieldType: CustomTextFieldType
    
    init(fieldType: CustomTextFieldType) {
        self.registrationFieldType = fieldType
        super.init(frame: .zero)
        
        setupLayout()
        setupAppearance()
        
        switch fieldType {
        case .name:
            placeholder = TextFieldResources.PlaceholderString.firstName
        case .lastName:
            placeholder = TextFieldResources.PlaceholderString.lastName
        case .email:
            placeholder = TextFieldResources.PlaceholderString.email
            keyboardType = .emailAddress
            textContentType = .emailAddress
        case .password:
            placeholder = TextFieldResources.PlaceholderString.password
            textContentType = .newPassword
            isSecureTextEntry = true
            addPasswordVisibilityButton()
        case .confirmPassword:
            placeholder = TextFieldResources.PlaceholderString.confirmPassword
            textContentType = .newPassword
            isSecureTextEntry = true
            addPasswordVisibilityButton()

        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CustomTextField {
    func setupAppearance() {
        backgroundColor = ColorResources.customDarkGrey
        layer.cornerRadius = 15
        textColor = ColorResources.white
        alpha = 0.95
        
        returnKeyType = .done
        autocorrectionType = .no
        autocapitalizationType = .none
        
        clearButtonMode = .whileEditing
        
        leftViewMode = .always
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.frame.size.height))
        
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 50),
            self.widthAnchor.constraint(equalToConstant: 350)
        ])
    }
}


