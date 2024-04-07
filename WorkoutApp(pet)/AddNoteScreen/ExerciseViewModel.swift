//
//  ExerciseViewModel.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 07.04.2024.
//

import UIKit

final class ExerciseViewModel {
        
    var exerciseUpdated: (() -> Void)?

    private(set) var allExercises: [Exercise] = [] {
        didSet {
            self.exerciseUpdated?()
        }
    }

    public func addExercise(exercise: Exercise) {
        allExercises.append(exercise)
    }

}

