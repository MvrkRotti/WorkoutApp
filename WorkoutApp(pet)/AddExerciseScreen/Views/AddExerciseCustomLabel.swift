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
        
        setupAppearance()
        
        switch labelType {
        case .sets:
            text = Const.sets
        case .reps:
            text = Const.reps
        case .min:
            text = Const.min
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension AddExerciseCustomLabel {
    func setupAppearance() {
        font = FontResources.addExerciseLabelFont
        textAlignment = .left
        tintColor = ColorResources.white
    }
}
