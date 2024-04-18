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
        setupAppearance()
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ExerciseNameLabel {
    func setupAppearance() {
        textColor = ColorResources.white
        textAlignment = .center
        font = FontResources.registrationLabelFont
        text = "Error"
        contentMode = .scaleAspectFill
        numberOfLines = 0
    }
}
