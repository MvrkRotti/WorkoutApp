//
//  AddNoteViewModel.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 09.04.2024.
//

import Foundation

class AddNoteViewModel {
    var exercises: [Exercise] = []

    func addExercise(exerciseName: String, numberOfSets: String, numberOfReps: String, restTime: String) {
        let newExercise = Exercise(exerciseName: exerciseName, numberOfSets: numberOfSets, numberOfReps: numberOfReps, restTime: restTime)
        exercises.append(newExercise)
    }
    
}
