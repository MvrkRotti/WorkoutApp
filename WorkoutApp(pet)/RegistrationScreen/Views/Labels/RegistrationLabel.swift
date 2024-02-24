//
//  RegistrationLabel.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 03.02.2024.
//

import UIKit

final class RegistrationLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupAppearence()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension RegistrationLabel {
    
    func setupAppearence() {
        
        text = Resources.RegistrationScreenStrings.registrationLabel
        font = Resources.CommonFonts.registrationLabelFont
        textAlignment = .left
        numberOfLines = 0
        textColor = Resources.CommonColors.white
        
    }
}
