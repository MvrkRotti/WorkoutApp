//
//  SignInLabel.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 03.02.2024.
//

import UIKit

final class SignInLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearence()
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SignInLabel {
    func setupAppearence() {
        textColor = Resources.Colors.customWhite
        textAlignment = .left
        font = Resources.Fonts.autLabelFont
        text = Resources.autorizedScreen.alreadyHaveAcc
    }
}

