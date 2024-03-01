//
//  ExerciseInfoViewModel.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 01.03.2024.
//

import UIKit
import Foundation

final class ExerciseInfoViewModel {
    //MARK: - Variables
    let exercise: Exercise
    
    //MARK: - Lifecycle
    init(_ exercise: Exercise) {
           self.exercise = exercise
       }

    //MARK: - Computed Properties
    
    var nameLabel: String {
        return self.exercise.name
    }
    
    var typeLabel: String {
        return "Type: \(self.exercise.type)"
    }
    
    
    var muscleLabel: String {
        return "Muscle: \(self.exercise.muscle)"
    }
    
    var equipmentLabel: String {
        return "Equipment: \(self.exercise.equipment)"
    }
    
    var difficultyLabel: String {
        return "Difficulty: \(self.exercise.difficulty)"
    }
    
    var instructionLabel: String {
        return "Instructions: \(self.exercise.instructions)"
    }
}

