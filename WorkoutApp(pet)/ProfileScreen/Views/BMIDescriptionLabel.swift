//
//  BMIDescriptionLabel.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 22.02.2024.
//

import UIKit

final class BMIDescriptionLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension BMIDescriptionLabel {
    func setupAppearance() {
        textColor = ColorResources.black
        font = FontResources.bmiDescriptionFont        
        numberOfLines = 0
    }
}

