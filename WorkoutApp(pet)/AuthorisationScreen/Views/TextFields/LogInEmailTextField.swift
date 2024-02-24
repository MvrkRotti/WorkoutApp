//
//  EmailTextField.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 04.02.2024.
//

import UIKit

final class LogInEmailTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearence()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: 330, y: 11, width: 20, height: 20)
    }
}

private extension LogInEmailTextField {
    
    func setupAppearence() {
        
        layer.cornerRadius = 15
        layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
        placeholder = Resources.TextField.PlaceholderString.email
        textColor = Resources.CommonColors.white
        backgroundColor = Resources.CommonColors.customDarkGrey
        clearButtonMode = .whileEditing
    }
}
