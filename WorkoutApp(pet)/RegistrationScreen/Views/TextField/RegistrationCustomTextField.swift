//
//  CustomTextField.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 26.03.2024.
//

import UIKit

final class RegistrationCustomTextField: UITextField {
    
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

        switch fieldType {
        case .name:
            placeholder = Const.firstName
        case .lastName:
            placeholder = Const.lastName
        case .email:
            placeholder = Const.email
            keyboardType = .emailAddress
            textContentType = .emailAddress
        case .password:
            placeholder = Const.password
            textContentType = .newPassword
            isSecureTextEntry = true
            addPasswordVisibilityButton()
        case .confirmPassword:
            placeholder = Const.confirmPassword
            textContentType = .newPassword
            isSecureTextEntry = true
            addPasswordVisibilityButton()
        }
        setupAppearance()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let bottomBorder = self.layer.sublayers?.first(where: { $0.borderColor == UIColor.black.cgColor }) {
            bottomBorder.frame = CGRect(x: 0, y: self.frame.size.height - bottomBorder.borderWidth, width: self.frame.size.width, height: bottomBorder.borderWidth)
        }
    }
}

private extension RegistrationCustomTextField {
    func setupAppearance() {
        
        textColor = ColorResources.black
        
        returnKeyType = .done
        autocorrectionType = .no
        autocapitalizationType = .none
        
        clearButtonMode = .whileEditing
        
        leftViewMode = .always
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.frame.size.height))
        
        let bottomBorder = CALayer()
        let borderWidth = CGFloat(1.0)
        bottomBorder.borderColor = UIColor.black.cgColor
        bottomBorder.frame = CGRect(x: 0, y: self.frame.size.height - borderWidth, width: self.frame.size.width, height: borderWidth)
        bottomBorder.borderWidth = borderWidth
        self.layer.addSublayer(bottomBorder)
        self.layer.masksToBounds = true
        
        self.attributedPlaceholder = NSAttributedString(
            string: placeholder!,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 50),
            self.widthAnchor.constraint(equalToConstant: 350)
        ])
    }
}


