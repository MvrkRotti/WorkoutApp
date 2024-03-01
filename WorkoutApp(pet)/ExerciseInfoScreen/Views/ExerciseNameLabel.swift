//
//  ExerciseNameLabel.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 01.03.2024.
//

import UIKit

final class ExerciseNameLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearence()
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ExerciseNameLabel {
    func setupAppearence() {
        textColor = Resources.CommonColors.white
        textAlignment = .center
        font = Resources.CommonFonts.registrationLabelFont
        text = "Error"
        contentMode = .scaleAspectFill
        numberOfLines = 0
    }
}
