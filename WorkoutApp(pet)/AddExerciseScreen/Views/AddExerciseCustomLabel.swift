//
//  AddExerciseCustomLabel.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 04.04.2024.
//

import UIKit

final class AddExerciseCustomLabel: UILabel {
    
    enum AddExerciseLabelType {
        case sets
        case reps
        case min
    }
    
    private let AddExerciseLabelType: AddExerciseLabelType
    
    init(labelType: AddExerciseLabelType) {
        self.AddExerciseLabelType = labelType
        super.init(frame: .zero)
        
        setupAppearence()
        
        switch labelType {
        case .sets:
            text = StringResources.CommonStrings.sets
        case .reps:
            text = StringResources.CommonStrings.reps
        case .min:
            text = StringResources.CommonStrings.min
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension AddExerciseCustomLabel {
    func setupAppearence() {
        font = FontResources.addExerciseLabelFont
        textAlignment = .left
        tintColor = ColorResources.white
    }
}
