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
        setupAppearence()
        
        switch fieldType {
        case .name:
            placeholder = Resources.TextField.PlaceholderString.firstName
        case .lastName:
            placeholder = Resources.TextField.PlaceholderString.lastName
        case .email:
            placeholder = Resources.TextField.PlaceholderString.email
            keyboardType = .emailAddress
            textContentType = .emailAddress
        case .password:
            placeholder = Resources.TextField.PlaceholderString.password
            textContentType = .oneTimeCode
            isSecureTextEntry = true
        case .confirmPassword:
            placeholder = Resources.TextField.PlaceholderString.confirmPassword
            textContentType = .oneTimeCode
            isSecureTextEntry = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CustomTextField {
    func setupAppearence() {
        backgroundColor = Resources.CommonColors.customDarkGrey
        layer.cornerRadius = 15
        textColor = Resources.CommonColors.white
        alpha = 0.95
        
        returnKeyType = .done
        autocorrectionType = .no
        autocapitalizationType = .none
        
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


