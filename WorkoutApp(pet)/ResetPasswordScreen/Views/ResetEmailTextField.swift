//
//  ResetEmailTextField.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 18.04.2024.
//

import UIKit

final class ResetEmailTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ResetEmailTextField {
    func setupAppearance() {
        placeholder = Const.email
        backgroundColor = ColorResources.customDarkGrey
        layer.cornerRadius = 15
        textColor = ColorResources.white
        alpha = 0.95
        keyboardType = .emailAddress
        
        returnKeyType = .done
        autocorrectionType = .no
        autocapitalizationType = .none
        
        clearButtonMode = .whileEditing
        
        leftViewMode = .always
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.frame.size.height))
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 335),
            heightAnchor.constraint(equalToConstant: 45)
        ])
    }
}
