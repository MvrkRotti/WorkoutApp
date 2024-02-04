//
//  LastNameTextField.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 04.02.2024.
//

import UIKit

final class LastNameTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupAppearence()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension LastNameTextField {
    
    func setupAppearence() {
        
        layer.cornerRadius = 15
        layer.borderColor = Resources.TextField.Colors.borderColor.cgColor
        layer.borderWidth = 2
        layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
        placeholder = Resources.TextField.Strings.lastName
        textColor = Resources.Colors.customWhite
        backgroundColor = Resources.Colors.customGrey   
    }
}
